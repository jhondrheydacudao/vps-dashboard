
-- Table: coupons
CREATE TABLE coupons (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(100) NOT NULL UNIQUE,
    discount INT NOT NULL,
    expires_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: database_hosts
CREATE TABLE database_hosts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    host VARCHAR(255) NOT NULL,
    port INT DEFAULT 3306,
    username VARCHAR(255) NOT NULL,
    password TEXT NOT NULL,
    max_databases INT DEFAULT 0
);

-- Table: databases
CREATE TABLE databases (
    id INT AUTO_INCREMENT PRIMARY KEY,
    server_id INT NOT NULL,
    database VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL,
    remote VARCHAR(255) DEFAULT '%',
    host_id INT NOT NULL,
    FOREIGN KEY (server_id) REFERENCES servers(id) ON DELETE CASCADE,
    FOREIGN KEY (host_id) REFERENCES database_hosts(id) ON DELETE CASCADE
);

-- Table: egg_mount
CREATE TABLE egg_mount (
    id INT AUTO_INCREMENT PRIMARY KEY,
    egg_id INT NOT NULL,
    mount_id INT NOT NULL,
    FOREIGN KEY (egg_id) REFERENCES eggs(id) ON DELETE CASCADE,
    FOREIGN KEY (mount_id) REFERENCES mounts(id) ON DELETE CASCADE
);

-- Table: egg_variables
CREATE TABLE egg_variables (
    id INT AUTO_INCREMENT PRIMARY KEY,
    egg_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    env_variable VARCHAR(255) NOT NULL,
    default_value TEXT,
    user_viewable BOOLEAN DEFAULT TRUE,
    user_editable BOOLEAN DEFAULT TRUE,
    rules TEXT,
    FOREIGN KEY (egg_id) REFERENCES eggs(id) ON DELETE CASCADE
);

-- Table: eggs
CREATE TABLE eggs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nest_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    docker_image VARCHAR(255) NOT NULL,
    config_startup TEXT,
    config_stop TEXT,
    config_logs TEXT,
    FOREIGN KEY (nest_id) REFERENCES nests(id) ON DELETE CASCADE
);

-- Table: failed_jobs
CREATE TABLE failed_jobs (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    connection TEXT NOT NULL,
    queue TEXT NOT NULL,
    payload LONGTEXT NOT NULL,
    exception LONGTEXT NOT NULL,
    failed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: jobs
CREATE TABLE jobs (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    queue VARCHAR(255) NOT NULL,
    payload LONGTEXT NOT NULL,
    attempts TINYINT DEFAULT 0,
    reserved_at INT,
    available_at INT,
    created_at INT
);

-- Table: locations
CREATE TABLE locations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    short VARCHAR(255) NOT NULL,
    long VARCHAR(255) NOT NULL
);

-- Table: migrations
CREATE TABLE migrations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    migration VARCHAR(255) NOT NULL,
    batch INT NOT NULL
);

-- Table: mount_node
CREATE TABLE mount_node (
    id INT AUTO_INCREMENT PRIMARY KEY,
    node_id INT NOT NULL,
    mount_id INT NOT NULL,
    FOREIGN KEY (node_id) REFERENCES nodes(id) ON DELETE CASCADE,
    FOREIGN KEY (mount_id) REFERENCES mounts(id) ON DELETE CASCADE
);

-- Table: mount_server
CREATE TABLE mount_server (
    id INT AUTO_INCREMENT PRIMARY KEY,
    server_id INT NOT NULL,
    mount_id INT NOT NULL,
    FOREIGN KEY (server_id) REFERENCES servers(id) ON DELETE CASCADE,
    FOREIGN KEY (mount_id) REFERENCES mounts(id) ON DELETE CASCADE
);

-- Table: mounts
CREATE TABLE mounts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    source TEXT,
    target TEXT
);

-- Table: nests
CREATE TABLE nests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    uuid VARCHAR(36) NOT NULL,
    author VARCHAR(255),
    name VARCHAR(255) NOT NULL,
    description TEXT
);

-- Table: nodes
CREATE TABLE nodes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location_id INT NOT NULL,
    fqdn VARCHAR(255) NOT NULL,
    scheme VARCHAR(10) NOT NULL DEFAULT 'https',
    memory INT NOT NULL,
    disk INT NOT NULL,
    upload_size INT DEFAULT 100,
    daemon_token_id VARCHAR(36),
    daemon_token VARCHAR(36),
    FOREIGN KEY (location_id) REFERENCES locations(id) ON DELETE CASCADE
);
