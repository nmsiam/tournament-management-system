-- Tournament Management System Database
-- PostgreSQL/MySQL compatible

CREATE DATABASE tournament_management;
USE tournament_management;

-- Admins table
CREATE TABLE admins (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tournaments table
CREATE TABLE tournaments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    image VARCHAR(255),
    prize_pool INTEGER NOT NULL,
    first_prize INTEGER NOT NULL,
    second_prize INTEGER NOT NULL,
    third_prize INTEGER NOT NULL,
    slot_price INTEGER NOT NULL,
    total_slots INTEGER NOT NULL,
    sold_slots INTEGER DEFAULT 0,
    end_time TIMESTAMP NOT NULL,
    group_link TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Registrations table
CREATE TABLE registrations (
    id SERIAL PRIMARY KEY,
    tournament_id INTEGER NOT NULL REFERENCES tournaments(id),
    team_name VARCHAR(255) NOT NULL,
    leader_name VARCHAR(255) NOT NULL,
    whatsapp_number VARCHAR(20) NOT NULL,
    payment_amount INTEGER NOT NULL,
    transaction_id VARCHAR(255),
    payment_time TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Payment settings table
CREATE TABLE payment_settings (
    id SERIAL PRIMARY KEY,
    brand_key VARCHAR(255) NOT NULL,
    api_key VARCHAR(255) NOT NULL,
    secret_key VARCHAR(255) NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Site settings table
CREATE TABLE site_settings (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    logo VARCHAR(255),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Admin sessions table
CREATE TABLE admin_sessions (
    id SERIAL PRIMARY KEY,
    admin_id INTEGER NOT NULL REFERENCES admins(id),
    device_info TEXT NOT NULL,
    ip_address VARCHAR(45),
    location VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    last_activity TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert default admin user (password: admin123)
INSERT INTO admins (email, password) VALUES 
('admin@tournament.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi');

-- Insert default site settings
INSERT INTO site_settings (title) VALUES ('NEXUS E-SPORTS');

-- Insert sample tournament
INSERT INTO tournaments (name, slug, prize_pool, first_prize, second_prize, third_prize, slot_price, total_slots, end_time, group_link) VALUES 
('PUBG Mobile Championship', 'pubg-mobile-championship', 10000, 5000, 3000, 2000, 50, 100, NOW() + INTERVAL '24 HOURS', 'https://chat.whatsapp.com/sample-group-link');

-- Create indexes for better performance
CREATE INDEX idx_tournaments_slug ON tournaments(slug);
CREATE INDEX idx_registrations_tournament ON registrations(tournament_id);
CREATE INDEX idx_admin_sessions_admin ON admin_sessions(admin_id);
