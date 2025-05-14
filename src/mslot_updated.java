import com.toedter.calendar.JDateChooser;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.*;
import java.sql.*;
import java.util.Date;

public class mslot_updated extends JFrame {

    private JTable slotsTable;
    private JButton btnBook, btnRefresh;
    private JDateChooser dateChooser;
    private DefaultTableModel tableModel;
    private int userId;

    public mslot_updated(int userId) {
        this.userId = userId;
        initComponents();
        loadSlots();
    }

    private void initComponents() {
        setTitle("Book a Slot");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(800, 600);
        setLocationRelativeTo(null);

        JPanel topPanel = new JPanel();
        topPanel.setLayout(new FlowLayout());

        JLabel dateLabel = new JLabel("Select Date:");
        dateChooser = new JDateChooser();
        dateChooser.setDate(new Date());

        btnRefresh = new JButton("Check Availability");
        btnRefresh.addActionListener(e -> loadSlots());

        topPanel.add(dateLabel);
        topPanel.add(dateChooser);
        topPanel.add(btnRefresh);

        tableModel = new DefaultTableModel(new String[]{"ID", "Doctor", "Date", "Time", "Status"}, 0);
        slotsTable = new JTable(tableModel);
        JScrollPane scrollPane = new JScrollPane(slotsTable);

        btnBook = new JButton("Book Selected Slot");
        btnBook.addActionListener(e -> bookSlot());

        JPanel bottomPanel = new JPanel();
        bottomPanel.add(btnBook);

        add(topPanel, BorderLayout.NORTH);
        add(scrollPane, BorderLayout.CENTER);
        add(bottomPanel, BorderLayout.SOUTH);
    }

    private void loadSlots() {
        tableModel.setRowCount(0);
        Date selectedDate = dateChooser.getDate();
        java.sql.Date sqlDate = new java.sql.Date(selectedDate.getTime());

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kldmass", "root", "")) {
            String query = "SELECT * FROM available_slots WHERE date = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setDate(1, sqlDate);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                tableModel.addRow(new Object[]{
                        rs.getInt("id"),
                        rs.getString("doctor_name"),
                        rs.getDate("date"),
                        rs.getString("time_slot"),
                        rs.getString("status")
                });
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error loading slots.", "Database Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void bookSlot() {
        int selectedRow = slotsTable.getSelectedRow();
        if (selectedRow == -1) {
            JOptionPane.showMessageDialog(this, "Please select a slot to book.", "No Selection", JOptionPane.WARNING_MESSAGE);
            return;
        }

        int slotId = (int) tableModel.getValueAt(selectedRow, 0);
        String doctor = (String) tableModel.getValueAt(selectedRow, 1);
        Date date = (Date) tableModel.getValueAt(selectedRow, 2);
        String time = (String) tableModel.getValueAt(selectedRow, 3);
        String status = (String) tableModel.getValueAt(selectedRow, 4);

        if (!"Available".equalsIgnoreCase(status)) {
            JOptionPane.showMessageDialog(this, "Selected slot is not available.", "Unavailable", JOptionPane.ERROR_MESSAGE);
            return;
        }

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kldmass", "root", "")) {
            conn.setAutoCommit(false);

            PreparedStatement updateSlot = conn.prepareStatement("UPDATE available_slots SET status = 'Booked' WHERE id = ?");
            updateSlot.setInt(1, slotId);
            updateSlot.executeUpdate();

            PreparedStatement insertBooking = conn.prepareStatement(
                    "INSERT INTO bookings (user_id, doctor_name, date, time_slot, status) VALUES (?, ?, ?, ?, 'Booked')");
            insertBooking.setInt(1, userId);
            insertBooking.setString(2, doctor);
            insertBooking.setDate(3, new java.sql.Date(date.getTime()));
            insertBooking.setString(4, time);
            insertBooking.executeUpdate();

            conn.commit();
            JOptionPane.showMessageDialog(this, "Booking successful.", "Success", JOptionPane.INFORMATION_MESSAGE);
            loadSlots();
        } catch (Exception e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Booking failed.", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new mslot(1).setVisible(true));
    }
}