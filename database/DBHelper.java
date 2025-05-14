
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DBHelper {
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/yourdb", "root", "");
    }

    public static List<DoctorInfo> getAllDoctors() {
        List<DoctorInfo> doctors = new ArrayList<>();
        String sql = "SELECT profile_id, DepartmentID, Dfull_name, schedule, specialization FROM doctor_infos";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                DoctorInfo doctor = new DoctorInfo(
                    rs.getString("profile_id"),
                    rs.getInt("DepartmentID")
                );
                doctor.name = rs.getString("Dfull_name");
                doctor.schedule = rs.getString("schedule");
                doctor.specialization = rs.getString("specialization");
                doctors.add(doctor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return doctors;
    }

    public static void insertOngoingAppointment(String userId, String doctorId, String schedule, int departmentId) {
        String sql = "INSERT INTO ongoingappointments (UserID, DoctorID, schedule, DepartmentID) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, userId);
            stmt.setString(2, doctorId);
            stmt.setString(3, schedule);
            stmt.setInt(4, departmentId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
