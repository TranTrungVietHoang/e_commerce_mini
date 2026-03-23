-- CREATE DATABASE
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'ecommerce_marketplace')
BEGIN
    CREATE DATABASE ecommerce_marketplace;
END
GO

USE ecommerce_marketplace;
GO

-- ==========================================
-- IDENTITY & ACCESS MANAGEMENT
-- ==========================================

-- Bảng Roles
CREATE TABLE roles (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Thêm Data mặc định cho Roles (ID cố định)
SET IDENTITY_INSERT roles ON;
INSERT INTO roles (id, name) VALUES 
(1, 'ROLE_CUSTOMER'),
(2, 'ROLE_SELLER'),
(3, 'ROLE_ADMIN');
SET IDENTITY_INSERT roles OFF;

-- Bảng MembershipLevels
CREATE TABLE membership_levels (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    min_points INT NOT NULL DEFAULT 0,
    discount_percent DECIMAL(5,2) NOT NULL DEFAULT 0,
    badge_icon VARCHAR(255)
);

-- Bảng Users
CREATE TABLE users (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name NVARCHAR(100) NOT NULL,
    phone VARCHAR(20) UNIQUE,
    avatar_url VARCHAR(255),
    membership_level_id INT,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (membership_level_id) REFERENCES membership_levels(id)
);
CREATE NONCLUSTERED INDEX IDX_Users_Email ON users(email);

-- User_Roles (Join table)
CREATE TABLE user_roles (
    user_id BIGINT NOT NULL,
    role_id INT NOT NULL,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE
);

-- RefreshTokens
CREATE TABLE refresh_tokens (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    user_id BIGINT NOT NULL,
    token VARCHAR(500) NOT NULL UNIQUE,
    expires_at DATETIME NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- ==========================================
-- SHOP & PRODUCT
-- ==========================================

-- Bảng Shops
CREATE TABLE shops (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    seller_id BIGINT NOT NULL UNIQUE,
    name NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX),
    logo_url VARCHAR(255),
    banner_url VARCHAR(255),
    status VARCHAR(20) DEFAULT 'PENDING',
    rating DECIMAL(3,2) DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (seller_id) REFERENCES users(id) ON DELETE CASCADE
);
CREATE NONCLUSTERED INDEX IDX_Shops_SellerId ON shops(seller_id);

-- Bảng Categories
CREATE TABLE categories (
    id INT IDENTITY(1,1) PRIMARY KEY,
    parent_id INT NULL,
    name NVARCHAR(100) NOT NULL,
    slug VARCHAR(150) NOT NULL UNIQUE,
    icon_url VARCHAR(255),
    FOREIGN KEY (parent_id) REFERENCES categories(id)
);

-- Bảng Products
CREATE TABLE products (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    shop_id BIGINT NOT NULL,
    category_id INT NOT NULL,
    name NVARCHAR(255) NOT NULL,
    slug VARCHAR(300) NOT NULL UNIQUE,
    description NVARCHAR(MAX),
    base_price DECIMAL(18,2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    rating DECIMAL(3,2) DEFAULT 0,
    sold_count BIGINT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (shop_id) REFERENCES shops(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);
CREATE NONCLUSTERED INDEX IDX_Products_ShopId ON products(shop_id);
CREATE NONCLUSTERED INDEX IDX_Products_CategoryId ON products(category_id);

-- Bảng ProductImages
CREATE TABLE product_images (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    product_id BIGINT NOT NULL,
    image_url VARCHAR(500) NOT NULL,
    is_primary BIT DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Bảng ProductVariants
CREATE TABLE product_variants (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    product_id BIGINT NOT NULL,
    sku VARCHAR(100) UNIQUE,
    attributes NVARCHAR(MAX), -- JSON chuỗi, ví dụ: {"Màu": "Đỏ", "Size": "L"}
    price DECIMAL(18,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- ==========================================
-- CART & ORDER
-- ==========================================

-- Bảng Carts
CREATE TABLE carts (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    user_id BIGINT NOT NULL UNIQUE,
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Bảng CartItems
CREATE TABLE cart_items (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    cart_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    variant_id BIGINT NULL,
    quantity INT NOT NULL DEFAULT 1,
    FOREIGN KEY (cart_id) REFERENCES carts(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (variant_id) REFERENCES product_variants(id),
    CONSTRAINT UQ_CartItem_Combine UNIQUE (cart_id, product_id, variant_id)
);
CREATE NONCLUSTERED INDEX IDX_CartItems_CartId ON cart_items(cart_id);

-- Bảng Vouchers
CREATE TABLE vouchers (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    shop_id BIGINT NULL, -- Nếu NULL thì áp dụng cho toàn sàn
    code VARCHAR(50) NOT NULL UNIQUE,
    discount_type VARCHAR(20) NOT NULL, -- PERCENTAGE, FIXED_AMOUNT
    discount_value DECIMAL(18,2) NOT NULL,
    min_order_value DECIMAL(18,2) DEFAULT 0,
    usage_limit INT DEFAULT 0,
    usage_count INT DEFAULT 0,
    expires_at DATETIME NOT NULL,
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (shop_id) REFERENCES shops(id)
);
CREATE NONCLUSTERED INDEX IDX_Vouchers_Code ON vouchers(code);

-- Bảng Orders
CREATE TABLE orders (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    customer_id BIGINT NOT NULL,
    shop_id BIGINT NOT NULL,
    voucher_id BIGINT NULL,
    subtotal DECIMAL(18,2) NOT NULL,
    discount_amount DECIMAL(18,2) DEFAULT 0,
    total_amount DECIMAL(18,2) NOT NULL,
    points_used INT DEFAULT 0,
    status VARCHAR(30) DEFAULT 'PENDING',
    shipping_address NVARCHAR(MAX) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (customer_id) REFERENCES users(id),
    FOREIGN KEY (shop_id) REFERENCES shops(id),
    FOREIGN KEY (voucher_id) REFERENCES vouchers(id)
);
CREATE NONCLUSTERED INDEX IDX_Orders_CustomerId ON orders(customer_id);
CREATE NONCLUSTERED INDEX IDX_Orders_ShopId ON orders(shop_id);

-- Bảng OrderItems
CREATE TABLE order_items (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    order_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    variant_id BIGINT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (variant_id) REFERENCES product_variants(id)
);

-- Bảng OrderStatusHistory
CREATE TABLE order_status_history (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    order_id BIGINT NOT NULL,
    status VARCHAR(30) NOT NULL,
    changed_at DATETIME DEFAULT GETDATE(),
    note NVARCHAR(MAX),
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);

-- ==========================================
-- LOYALTY & PROMOTION
-- ==========================================

-- Bảng VoucherUsage
CREATE TABLE voucher_usage (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    voucher_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    order_id BIGINT NOT NULL,
    used_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (voucher_id) REFERENCES vouchers(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- Bảng Points
CREATE TABLE points (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    user_id BIGINT NOT NULL UNIQUE,
    total_points INT DEFAULT 0,
    available_points INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Bảng PointHistory
CREATE TABLE point_history (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    user_id BIGINT NOT NULL,
    order_id BIGINT NULL,
    points INT NOT NULL,
    type VARCHAR(20) NOT NULL, -- EARN, REDEEM
    description NVARCHAR(255),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- ==========================================
-- SOCIAL & UX
-- ==========================================

-- Bảng Reviews
CREATE TABLE reviews (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    product_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    order_item_id BIGINT NOT NULL UNIQUE, -- Mỗi order item chỉ được review 1 lần
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (order_item_id) REFERENCES order_items(id)
);

-- Bảng Wishlists
CREATE TABLE wishlists (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    user_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    added_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id), -- Bỏ CASCADE để tránh lỗi multiple cascade paths trong SQL Server
    CONSTRAINT UQ_User_Product UNIQUE (user_id, product_id)
);

-- Bảng Notifications
CREATE TABLE notifications (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    user_id BIGINT NOT NULL,
    title NVARCHAR(255) NOT NULL,
    message NVARCHAR(MAX) NOT NULL,
    type VARCHAR(50) NOT NULL,
    is_read BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
CREATE NONCLUSTERED INDEX IDX_Notifications_UserId ON notifications(user_id);

-- ==========================================
-- ADVANCED FEATURES (TÍNH NĂNG CAO)
-- ==========================================

-- Bảng FlashSales (Đợt giảm giá chớp nhoáng)
CREATE TABLE flash_sales (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    status VARCHAR(20) DEFAULT 'INACTIVE', -- ACTIVE, INACTIVE, ENDED
    created_at DATETIME DEFAULT GETDATE()
);

-- Bảng FlashSaleProducts (Sản phẩm trong đợt Flash Sale)
CREATE TABLE flash_sale_products (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    flash_sale_id INT NOT NULL,
    product_id BIGINT NOT NULL,
    sale_price DECIMAL(18,2) NOT NULL,
    stock_limit INT NOT NULL, 
    sold_count INT DEFAULT 0,
    FOREIGN KEY (flash_sale_id) REFERENCES flash_sales(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Bảng ChatMessages (Lịch sử chat Buyer - Seller)
CREATE TABLE chat_messages (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    sender_id BIGINT NOT NULL,
    receiver_id BIGINT NOT NULL,
    shop_id BIGINT NULL,
    message NVARCHAR(MAX) NOT NULL,
    is_read BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (sender_id) REFERENCES users(id),
    FOREIGN KEY (receiver_id) REFERENCES users(id),
    FOREIGN KEY (shop_id) REFERENCES shops(id)
);
CREATE NONCLUSTERED INDEX IDX_Chat_Sender ON chat_messages(sender_id);
CREATE NONCLUSTERED INDEX IDX_Chat_Receiver ON chat_messages(receiver_id);

-- Bảng VerificationTokens (Xác thực Email / Quên mật khẩu)
CREATE TABLE verification_tokens (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    user_id BIGINT NOT NULL,
    token VARCHAR(255) NOT NULL UNIQUE,
    type VARCHAR(50) NOT NULL, -- EMAIL_VERIFY, PASSWORD_RESET
    expires_at DATETIME NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
