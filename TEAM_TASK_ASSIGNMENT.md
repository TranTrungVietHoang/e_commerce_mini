# 🛡️ BẢN PHÂN CHIA NHIỆM VỤ CHI TIẾT (7 THÀNH VIÊN FULLSTACK) - PHIÊN BẢN CHUẨN HÓA

Bản danh sách này liệt kê **cụ thể từng chức năng**, **mô tả logic** và **phân chia trách nhiệm** từng tầng (DB, BE, FE) để đảm bảo không bỏ sót bất kỳ yêu cầu nào.

---

### 👤 THÀNH VIÊN 1: NHÓM TRƯỞNG (Hệ Thống - Bảo Mật - Quản Trị User)

**1. Chức năng Đăng ký/Đăng nhập (Auth):**
*   **Mô tả:** Hệ thống đăng nhập tập trung dùng JWT. Hỗ trợ xác thực người dùng và phân quyền (Role-based Access Control).
*   **DB:** `users`, `roles`, `user_roles`, `refresh_tokens`.
*   **BE:** API Login (trả về Token), API Register (mã hóa mật khẩu BCrypt), API Refresh Token.
*   **FE:** Trang Login, Trang Register (validate dữ liệu đầu vào).

**2. Quản lý Hồ sơ Cá nhân (Profile):**
*   **Mô tả:** Người dùng xem và sửa thông tin cá nhân, đổi mật khẩu.
*   **BE/FE:** API & Trang Profile cá nhân.

**3. Quản trị Người dùng (Admin Dashboard):**
*   **Mô tả:** Admin tìm kiếm, xem chi tiết và Khóa/Mở tài khoản người dùng vi phạm.
*   **BE/FE:** API & Trang danh sách thành viên cho Admin.

**4. Quên mật khẩu & OTP (Advanced):**
*   **Mô tả:** Gửi mã xác nhận qua Email để đặt lại mật khẩu.
*   **BE:** Tích hợp JavaMailSender, logic tạo/hết hạn mã OTP.

---

### 👤 THÀNH VIÊN 2: QUẢN LÝ GIAN HÀNG & DANH MỤC (Shops & Categories)

**1. Đăng ký & Quản lý Shop (Seller):**
*   **Mô tả:** Khách hàng đăng ký làm Người bán. Shop có trạng thái PENDING cho đến khi Admin duyệt.
*   **DB:** `shops`.
*   **BE:** API Đăng ký Shop, API cập nhật thông tin Shop (Logo, Mô tả).
*   **FE:** Form đăng ký Shop, Dashboard thông tin cơ bản cho Shop.

**2. Phê duyệt Shop (Admin):**
*   **Mô tả:** Admin xem danh sách Shop chờ duyệt và bấm "Approve" hoặc "Reject".
*   **BE/FE:** API cập nhật status Shop, Trang danh sách Shop chờ duyệt cho Admin.

**3. Quản lý Danh mục (Admin):**
*   **Mô tả:** Quản lý cây danh mục sản phẩm (Ví dụ: Điện thoại -> iPhone).
*   **DB:** `categories` (hỗ trợ parent_id).
*   **BE/FE:** API & Trang Admin quản lý danh mục (Thêm/Sửa/Xóa).

---

### 👤 THÀNH VIÊN 3: QUẢN LÝ SẢN PHẨM & KHO (Products & Inventory)

**1. Quản lý Sản phẩm chính (CMS):**
*   **Mô tả:** Người bán thêm sản phẩm mới kèm tên, mô tả, danh mục và hàng loạt ảnh.
*   **DB:** `products`, `product_images`.
*   **BE:** API CRUD Sản phẩm (Soft Delete), Tích hợp Cloudinary/S3 để lưu ảnh.
*   **FE:** Form thêm/sửa sản phẩm phức tạp, danh sách sản phẩm của Shop.

**2. Hệ thống Biến thể (Variants):**
*   **Mô tả:** Một sản phẩm có nhiều thuộc tính (Màu: Đỏ/Xanh, Size: L/XL), mỗi tổ hợp có giá và số kho riêng.
*   **DB:** `product_variants`.
*   **BE:** Logic lưu trữ variant matrix.
*   **FE:** Giao diện nhập biến thể thông minh cho Seller.

**3. Quản lý Tồn kho (Inventory):**
*   **Mô tả:** Theo dõi số lượng còn lại, cảnh báo khi kho bằng 0.
*   **BE:** API cập nhật số lượng kho nhanh từ Dashboard.

---

### 👤 THÀNH VIÊN 4: KHÁM PHÁ & TÌM KIẾM (Shopping Experience & Discovery)

**1. Trang chủ & Điều hướng (Home):**
*   **Mô tả:** Hiển thị Banner, Sản phẩm mới nhất, Sản phẩm bán chạy.
*   **FE:** UI Trang chủ, Menu danh mục, Sidebar lọc sản phẩm.

**2. Tìm kiếm thông minh (Search):**
*   **Mô tả:** Tìm theo từ khóa, gợi ý tìm kiếm (Autocomplete) ,các phương thức tìm kiếm nâng cao, lọc theo giá và đánh giá.
*   **BE:** API Search đa tiêu chí (Custom JPA Query/Specification).
*   **FE:** Trang kết quả tìm kiếm với bộ lọc (Filter) bên trái.

**3. Trang Chi tiết Sản phẩm (PDP):**
*   **Mô tả:** Hiển thị ảnh gallery, giá thay đổi theo variant được chọn, mô tả sản phẩm, danh sách review.
*   **FE:** UI Chi tiết sản phẩm, logic chọn variant (Color/Size) để hiện đúng giá.

---

### 👤 THÀNH VIÊN 5: GIỎ HÀNG & KHUYẾN MÃI (Cart & Vouchers & Flash Sales)

**1. Giỏ hàng (Shopping Cart):**
*   **Mô tả:** Thêm/sửa số lượng/xóa sản phẩm. Lưu giỏ hàng vào Database để đồng bộ mọi máy.
*   **DB:** `carts`, `cart_items`.
*   **BE:** API đồng bộ giỏ hàng, BE kiểm tra số lượng tồn kho khi add.
*   **FE:** Drawer giỏ hàng nhanh và Trang giỏ hàng đầy đủ.

**2. Hệ thống Voucher (Promotions):**
*   **Mô tả:** Tạo mã giảm giá (Theo % hoặc số tiền). Voucher có hạn sử dụng và số lượng.
*   **DB:** `vouchers`.
*   **BE:** API áp dụng Voucher (kiểm tra điều kiện đơn hàng), API CRUD Voucher (Seller/Admin).
*   **FE:** Hiện danh sách Voucher có thể dùng, ô nhập mã giảm giá.

**3. Flash Sale (Events):**
*   **Mô tả:** Giảm giá đặc biệt trong khung giờ nhất định.
*   **BE/FE:** Logic đếm ngược (Countdown) và giá Flash Sale ưu tiên.

---

### 👤 THÀNH VIÊN 6: ĐẶT HÀNG & THANH TOÁN (Orders & Revenue)

**1. Quy trình Checkout (Thanh Toán):**
*   **Mô tả:** Khách chọn địa chỉ, chọn phương thức thanh toán, hệ thống tạo đơn và trừ kho.
*   **DB:** `orders`, `order_items`.
*   **BE:** API tạo Order, logic trừ số lượng variant stock, tích hợp VNPAY (Sandbox).
*   **FE:** Trang checkout từng bước (Shipping -> Payment -> Success).

**2. Quản lý Đơn hàng (OMS):**
*   **Mô tả:** Theo dõi đơn hàng qua các bước: CHỜ DUYỆT -> ĐÃ XÁC NHẬN -> ĐANG GIAO -> THÀNH CÔNG/HỦY.
*   **DB:** `order_status_history`.
*   **BE/FE:** API cập nhật trạng thái đơn (Seller), xem lịch sử mua hàng (Customer).

**3. Thống kê Doanh thu (Charts):**
*   **Mô tả:** Báo cáo doanh số cho Seller và Admin theo thời gian.
*   **BE/FE:** API thống kê tổng tiền, số đơn. Biểu đồ Chart.js hiển thị doanh thu.

---

### 👤 THÀNH VIÊN 7: TƯƠNG TÁC & THÔNG BÁO & SOCKET (Loyalty & Social)

**1. Đánh giá & Yêu thích (Review & Wishlist):**
*   **Mô tả:** Khách đã mua hàng mới được đánh giá. Quản lý danh sách sản phẩm thích.
*   **DB:** `reviews`, `wishlists`.
*   **BE/FE:** Đánh giá sao, upload ảnh review. Trang Wishlist cá nhân.

**2. Thông báo & Chat Real-time (WebSocket):**
*   **Mô tả:** Thông báo tức thời khi có đơn mới (Seller) hoặc đơn đổi trạng thái (Buyer). Chat trực tiếp.
*   **DB:** `notifications`, `chat_messages`.
*   **BE:** Cấu hình Spring Boot WebSocket (Pusher/Socket.io).
*   **FE:** Chuông thông báo (Badge), Cửa sổ Chat nhỏ ở góc màn hình.

**3. Điểm thưởng & Hạng thành viên (Loyalty):**
*   **Mô tả:** Tích điểm khi mua hàng thành công. Nâng cấp hạng thành viên để nhận ưu đãi ship/giảm giá.
*   **DB:** `membership_levels`, `points`.
*   **BE:** Logic tự động cộng điểm sau khi đơn hàng ở trạng thái DELIVERED.

---

### 💡 LỜI KHUYÊN CHO NHÓM TRƯỞNG:
*   Hãy đảm bảo 7 thành viên **đọc kỹ phần logic** để tránh Code chồng chéo.
*   Bản phân chia này đã đảm bảo **không có chức năng nào bị bỏ trống**.
*   Các thành viên làm việc theo **Mô hình Song song**: Ai xong DB -> Viết API -> Dựng UI ngay cho phần đó.
