-- PostgreSQL Database Schema for Call Center RTA System

-- Table for Call Center Agents
CREATE TABLE agents (
    agent_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    extension VARCHAR(10) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    hire_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'active'
);

-- Table for Calls
CREATE TABLE calls (
    call_id SERIAL PRIMARY KEY,
    agent_id INT NOT NULL REFERENCES agents(agent_id),
    caller_id VARCHAR(15) NOT NULL,
    call_start TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    call_end TIMESTAMP,
    duration INT,
    status VARCHAR(20) DEFAULT 'completed'
);

-- Table for Call Outcomes
CREATE TABLE call_outcomes (
    outcome_id SERIAL PRIMARY KEY,
    description VARCHAR(100) NOT NULL UNIQUE
);

-- Table for Call Records
CREATE TABLE call_records (
    record_id SERIAL PRIMARY KEY,
    call_id INT NOT NULL REFERENCES calls(call_id),
    outcome_id INT NOT NULL REFERENCES call_outcomes(outcome_id),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for Call Center Departments
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100)
);

-- Table for Agents and their Departments
CREATE TABLE agent_departments (
    agent_department_id SERIAL PRIMARY KEY,
    agent_id INT NOT NULL REFERENCES agents(agent_id),
    department_id INT NOT NULL REFERENCES departments(department_id),
    start_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    end_date TIMESTAMP
);