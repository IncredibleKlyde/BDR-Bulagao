package Config;

public class User {

    private static User instance;

    private int userId;
    private String username;
    private String role;

    // Private constructor (Singleton)
    private User() {
    }

    // Get single instance
    public static User getInstance() {
        if (instance == null) {
            instance = new User();
        }
        return instance;
    }

    // =========================
    // SET USER SESSION
    // =========================
    public void setUser(int userId, String username, String role) {
        this.userId = userId;
        this.username = username;
        this.role = role;
    }

    // =========================
    // GETTERS
    // =========================
    public int getUserId() {
        return userId;
    }

    public String getUsername() {
        return username;
    }

    public String getRole() {
        return role;
    }

    // =========================
    // CLEAR SESSION (Logout)
    // =========================
    public void clearSession() {
        userId = 0;
        username = null;
        role = null;
    }
}