CREATE DATABASE x_db;
USE DATABASE x_db;

CREATE TABLE users (
    id CHAR(36) PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    email VARCHAR(60) NOT NULL,
    password CHAR(255) NOT NULL,
    dob DATE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW()
);

CREATE TABLE posts (
    id INT  PRIMARY KEY AUTO_INCREMENT,
    content VARCHAR(255) NOT NULL,
    content_img_id CHAR(36), 
    user_id CHAR(36) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW(), 
    FOREIGN KEY (content_img_id) REFERENCES images(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
)

CREATE TABLE images (
    id INT PRIMARY KEY AUTO_INCREMENT,
    content BLOB, 
    user_id CHAR(36) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(), 
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE likes (
    post_id INT NOT NULL,
    likee_id CHAR(36) NOT NULL,
    liker_id CHAR(36) NOT NULL
    PRIMARY KEY(likee_id, liker_id)
    FOREIGN KEY post_id REFERENCES posts(id),
    FOREIGN KEY likee_id REFERENCES users(id),
    FOREIGN KEY liker_id REFERENCES users(id), 
    liked_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE reposts (
    repost_id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT NOT NULL, 
    user_id CHAR(36) NOT NULL,
    content VARCHAR(140), 
    content_img_id INT, 
    reposted_at TIMESTAMP DEFAULT NOW(), 
    FOREIGN KEY (post_id) REFERENCES posts(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (content_img_id) REFERENCES images(id)
);

CREATE TABLE comments (
    post_id INT NOT NULL,
    commenter_id CHAR(36) NOT NULL,
    comment VARCHAR(140) NOT NULL,
    commented_at TIMESTAMP DEFAULT NOW(), 
    PRIMARY KEY (commenter_id, comment), 
    FOREIGN KEY (post_id) REFERENCES posts(id),
    FOREIGN KEY (commenter_id) REFERENCES users(id)
);

-- Need something to handle comments on comments or just keep it one level? 
-- Need something to handle likes, reposts on comments?
