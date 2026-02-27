
-- =========================================
-- BARANGAY DOCUMENT REQUEST SYSTEM (SQLite)
-- =========================================

PRAGMA foreign_keys = ON;

-- =========================================
-- USERS TABLE
-- =========================================
CREATE TABLE users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    middle_name TEXT,
    last_name TEXT NOT NULL,
    role TEXT NOT NULL CHECK(role IN ('Admin','Barangay Captain','Purok Leader')),
    contact_number TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    username TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    status TEXT NOT NULL CHECK(status IN ('Active','Inactive')),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- =========================================
-- RESIDENTS TABLE
-- =========================================
CREATE TABLE residents (
    resident_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    middle_name TEXT,
    last_name TEXT NOT NULL,
    birthdate DATE NOT NULL,
    gender TEXT NOT NULL CHECK(gender IN ('Male','Female')),
    civil_status TEXT NOT NULL CHECK(civil_status IN ('Single','Married','Widowed','Separated')),
    contact_number TEXT,
    address TEXT NOT NULL,
    purok TEXT,
    status TEXT DEFAULT 'Active' CHECK(status IN ('Active','Inactive')),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- =========================================
-- DOCUMENTS TABLE
-- =========================================
CREATE TABLE documents (
    document_id INTEGER PRIMARY KEY AUTOINCREMENT,
    document_name TEXT NOT NULL,
    description TEXT,
    fee REAL NOT NULL,
    processing_days INTEGER NOT NULL,
    status TEXT DEFAULT 'Available' CHECK(status IN ('Available','Unavailable')),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- =========================================
-- REQUESTS TABLE
-- =========================================
CREATE TABLE requests (
    request_id INTEGER PRIMARY KEY AUTOINCREMENT,
    resident_id INTEGER NOT NULL,
    document_id INTEGER NOT NULL,
    purpose TEXT NOT NULL,
    request_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status TEXT DEFAULT 'Pending' CHECK(status IN ('Pending','Approved','Rejected','Released')),
    approved_by INTEGER,
    approved_at DATETIME,
    remarks TEXT,

    FOREIGN KEY (resident_id) REFERENCES residents(resident_id) ON DELETE CASCADE,
    FOREIGN KEY (document_id) REFERENCES documents(document_id) ON DELETE CASCADE,
    FOREIGN KEY (approved_by) REFERENCES users(user_id) ON DELETE SET NULL
);

-- =========================================
-- PAYMENTS TABLE
-- =========================================
CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    request_id INTEGER NOT NULL,
    amount REAL NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_method TEXT,

    FOREIGN KEY (request_id) REFERENCES requests(request_id) ON DELETE CASCADE
);

-- =========================================
-- AUDIT LOG TABLE
-- =========================================
CREATE TABLE audit_logs (
    log_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    action TEXT NOT NULL,
    table_name TEXT,
    record_id INTEGER,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

-- =========================================
-- INDEXES
-- =========================================
CREATE INDEX idx_requests_resident ON requests(resident_id);
CREATE INDEX idx_requests_document ON requests(document_id);
CREATE INDEX idx_requests_status ON requests(status);
CREATE INDEX idx_residents_lastname ON residents(last_name);

-- =========================================
-- SAMPLE DATA
-- =========================================

INSERT INTO users 
(first_name, last_name, role, contact_number, email, username, password, status)
VALUES 
('System', 'Administrator', 'Admin', '09123456789', 'admin@barangay.com', 'admin', 'admin123', 'Active');

INSERT INTO documents (document_name, description, fee, processing_days)
VALUES
('Barangay Clearance', 'General purpose clearance document', 50.00, 1),
('Certificate of Indigency', 'For financial assistance applications', 0.00, 1),
('Business Clearance', 'Required for business permit', 150.00, 2);

INSERT INTO residents
(first_name, last_name, birthdate, gender, civil_status, address, purok)
VALUES
('Juan', 'Dela Cruz', '1995-05-10', 'Male', 'Single', 'Purok 3, Barangay Proper', 'Purok 3');
