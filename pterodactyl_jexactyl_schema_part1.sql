
-- FULL SQL SCHEMA: PTERODACTYL + JEXACTYL

-- Table: activity_log_subjects
CREATE TABLE activity_log_subjects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    log_id INT NOT NULL,
    subject_type VARCHAR(255) NOT NULL,
    subject_id INT NOT NULL
);

-- Table: activity_logs
CREATE TABLE activity_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    actor_id INT,
    event VARCHAR(255) NOT NULL,
    ip VARCHAR(45),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table: allocations
CREATE TABLE allocations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    node_id INT NOT NULL,
    ip VARCHAR(255) NOT NULL,
    port INT NOT NULL,
    server_id INT,
    FOREIGN KEY (node_id) REFERENCES nodes(id) ON DELETE CASCADE
);

-- Table: analytics_data
CREATE TABLE analytics_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    key_name VARCHAR(255) NOT NULL,
    value TEXT NOT NULL
);

-- Table: analytics_messages
CREATE TABLE analytics_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: api_keys
CREATE TABLE api_keys (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifier VARCHAR(64) NOT NULL,
    token VARCHAR(64) NOT NULL,
    user_id INT NOT NULL,
    last_used_at TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Table: api_logs
CREATE TABLE api_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    key_id INT,
    ip VARCHAR(45) NOT NULL,
    endpoint TEXT NOT NULL,
    method VARCHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (key_id) REFERENCES api_keys(id) ON DELETE SET NULL
);

-- Table: backups
CREATE TABLE backups (
    id INT AUTO_INCREMENT PRIMARY KEY,
    uuid VARCHAR(36) NOT NULL UNIQUE,
    server_id INT NOT NULL,
    name VARCHAR(255),
    is_successful BOOLEAN DEFAULT FALSE,
    is_locked BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (server_id) REFERENCES servers(id) ON DELETE CASCADE
);

-- (Due to length constraints, this file will include the remaining tables next.)
-- You can request the full schema in multiple parts or get the final download file directly.
