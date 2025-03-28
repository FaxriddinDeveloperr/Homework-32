CREATE TABLE users
(
    user_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(50),
    password INT NOT NULL UNIQUE,
    phone_number INT NOT NULL UNIQUE,
    address VARCHAR(50)
);


INSERT INTO users (first_name, last_name, email, password, phone_number, address) VALUES
('Ali', 'Hasanov', 'ali.hasanov@example.com', 'hashed_password1', '+998901234567', 'Tashkent, Uzbekistan'),
('Bekzod', 'Karimov', 'bekzod.karimov@example.com', 'hashed_password2', '+998902345678', 'Samarkand, Uzbekistan'),
('Shahnoza', 'Oripova', 'shahnoza.oripova@example.com', 'hashed_password3', '+998903456789', 'Bukhara, Uzbekistan'),
('Jasur', 'Rakhimov', 'jasur.rakhimov@example.com', 'hashed_password4', '+998904567890', 'Andijan, Uzbekistan'),
('Dilfuza', 'Solieva', 'dilfuza.solieva@example.com', 'hashed_password5', '+998905678901', 'Namangan, Uzbekistan'),
('Umid', 'Tursunov', 'umid.tursunov@example.com', 'hashed_password6', '+998906789012', 'Fergana, Uzbekistan'),
('Aziza', 'Sodiqova', 'aziza.sodiqova@example.com', 'hashed_password7', '+998907890123', 'Jizzakh, Uzbekistan'),
('Murod', 'Norboyev', 'murod.norboyev@example.com', 'hashed_password8', '+998908901234', 'Navoiy, Uzbekistan'),
('Lola', 'Xudoyberdieva', 'lola.xudoyberdieva@example.com', 'hashed_password9', '+998909012345', 'Khorezm, Uzbekistan'),
('Sardor', 'Eshonqulov', 'sardor.eshonqulov@example.com', 'hashed_password10', '+998901122334', 'Surkhandarya, Uzbekistan'),
('Madina', 'Yusupova', 'madina.yusupova@example.com', 'hashed_password11', '+998902233445', 'Tashkent, Uzbekistan'),
('Rustam', 'Abdullayev', 'rustam.abdullayev@example.com', 'hashed_password12', '+998903344556', 'Samarkand, Uzbekistan'),
('Ziyoda', 'Sheralieva', 'ziyoda.sheralieva@example.com', 'hashed_password13', '+998904455667', 'Bukhara, Uzbekistan'),
('Baxtiyor', 'Hamidov', 'baxtiyor.hamidov@example.com', 'hashed_password14', '+998905566778', 'Andijan, Uzbekistan'),
('Gulnora', 'Ismoilova', 'gulnora.ismoilova@example.com', 'hashed_password15', '+998906677889', 'Fergana, Uzbekistan');








-- CREATE POSTS TABLE
CREATE TABLE posts
(
    post_id SERIAL PRIMARY KEY,
    title VARCHAR,
    content TEXT,
    slug VARCHAR,
    user_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    author_id INT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES users(user_id)
);


INSERT INTO posts (title, content, slug, user_id, author_id) VALUES
('First Post', 'This is the content of the first post.', 'first-post', 1, 1),
('Tech Trends 2025', 'Exploring the latest technology trends.', 'tech-trends-2025', 2, 2),
('Programming Best Practices', 'Learn how to write clean and efficient code.', 'programming-best-practices', 3, 3),
('Database Optimization', 'How to optimize your database queries.', 'database-optimization', 4, 4),
('Cybersecurity Tips', 'Protect yourself online with these tips.', 'cybersecurity-tips', 5, 5),
('AI in Daily Life', 'How artificial intelligence is shaping our world.', 'ai-daily-life', 6, 6),
('Introduction to Web Development', 'A beginner-friendly guide to web development.', 'intro-web-dev', 7, 7),
('Mastering Python', 'Advanced techniques for Python developers.', 'mastering-python', 8, 8),
('Cloud Computing Explained', 'What is cloud computing and why does it matter?', 'cloud-computing', 9, 9),
('The Future of Blockchain', 'How blockchain technology is evolving.', 'future-blockchain', 10, 10),
('Frontend vs Backend', 'Understanding the differences between frontend and backend development.', 'frontend-vs-backend', 11, 11),
('Data Science Basics', 'Getting started with data science.', 'data-science-basics', 12, 12),
('Mobile App Development', 'How to build mobile applications.', 'mobile-app-development', 13, 13),
('Software Engineering Myths', 'Debunking common myths about software engineering.', 'software-engineering-myths', 14, 14),
('Career Tips for Developers', 'Advice for aspiring developers.', 'career-tips-devs', 15, 15);








-- CREATE TABLE COMMENTS
CREATE TABLE comments
(
    comment_id SERIAL PRIMARY KEY,
    content TEXT,
    post_id INT NOT NULL,
    author_id INT NOT NULL,
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    FOREIGN KEY (author_id) REFERENCES users(user_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



INSERT INTO comments (content, post_id, author_id) VALUES
('Great post! Really informative.', 1, 2),
('Thanks for sharing, this was helpful.', 2, 3),
('I totally agree with your points.', 3, 4),
('Could you explain this part in more detail?', 4, 5),
('This is a very well-written article.', 5, 6),
('I learned a lot from this post!', 6, 7),
('Interesting perspective, thanks!', 7, 8),
('What do you think about the latest updates?', 8, 9),
('I have a question about this topic.', 9, 10),
('This was exactly what I was looking for.', 10, 11),
('Your explanation is very clear, thank you!', 11, 12),
('I appreciate the effort you put into this.', 12, 13),
('This post helped me understand better.', 13, 14),
('Well done! Keep writing more content like this.', 14, 15),
('This was insightful. Looking forward to more posts.', 15, 1);
