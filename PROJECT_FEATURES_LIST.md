# 📋 DANH SÁCH TÍNH NĂNG DỰ ÁN E-COMMERCE MARKETPLACE

Dự án được thiết kế theo mô hình Marketplace (Sàn TMĐT đa gian hàng), hỗ trợ 3 đối tượng người dùng: **Khách hàng**, **Chủ shop**, và **Quản trị viên (Admin)**.

---

## I. NHÓM TÍNH NĂNG CHUNG (HỆ THỐNG)
*Phần nền móng phục vụ cho tất cả các bên.*

1.  **Xác thực & Bảo mật (Auth):**
    *   Đăng ký tài khoản (Dành cho Khách hàng & Người bán).
    *   Đăng nhập (Sử dụng JWT - JSON Web Token).
    *   Đăng xuất & Làm mới phiên đăng nhập (Refresh Token).
    *   ⭐ **[TÍNH NĂNG CAO]** Quên mật khẩu & Lấy lại qua Email OTP.
    *   ⭐ **[TÍNH NĂNG CAO]** Bảo mật 2 lớp (Mã xác thực email).
2.  **Thông báo (Notifications):**
    *   Nhận thông báo khi có đơn hàng mới, thay đổi trạng thái đơn, hoặc có Voucher mới.
    *   ⭐ **[TÍNH NĂNG CAO]** Thông báo thời gian thực (Live Notification via WebSocket).
3.  **Nhắn tin (Chat):**
    *   ⭐ **[TÍNH NĂNG CAO]** Chat Real-time giữa Khách hàng và Chủ shop để tư vấn sản phẩm.

---

## II. DÀNH CHO KHÁCH HÀNG (CUSTOMER)
*Trọng tâm: Trải nghiệm mua sắm mượt mà.*

1.  **Duyệt & Tìm kiếm sản phẩm:**
    *   Xem danh sách sản phẩm theo danh mục (Category).
    *   Lọc sản phẩm theo giá, đánh giá sao, shop.
    *   Tìm kiếm sản phẩm theo tên.
    *   ⭐ **[TÍNH NĂNG CAO]** Tìm kiếm gợi ý (Autocomplete Search) - Gợi ý từ khóa ngay khi gõ.
    *   ⭐ **[TÍNH NĂNG CAO]** Gợi ý sản phẩm liên quan (Related Products) dựa trên danh mục.
2.  **Quản lý Giỏ hàng:**
    *   Thêm sản phẩm (kèm biến thể: màu sắc, kích cỡ) vào giỏ hàng.
    *   Cập nhật số lượng, xóa sản phẩm khỏi giỏ.
    *   Tự động tính tổng tiền (Subtotal).
3.  **Đặt hàng & Thanh toán (Checkout):**
    *   Nhập địa chỉ giao hàng.
    *   Chọn phương thức thanh toán (COD, Chuyển khoản).
    *   Áp dụng mã giảm giá (Voucher).
    *   ⭐ **[TÍNH NĂNG CAO]** Thanh toán Online qua cổng VNPAY/MOMO (Sandbox).
4.  **Quản lý Đơn hàng:**
    *   Xem lịch sử đơn hàng.
    *   Hủy đơn hàng (Khi đơn ở trạng thái CHỜ DUYỆT).
    *   ⭐ **[TÍNH NĂNG CAO]** Theo dõi hành trình đơn hàng (Order Timeline).
5.  **Tương tác & Ưu đãi:**
    *   Đánh giá (Review) sản phẩm kèm hình ảnh và số sao (1-5).
    *   Quản lý danh sách yêu thích (Wishlist).
    *   Tích lũy điểm thưởng (Points) sau mỗi lần mua hàng thành công.
    *   ⭐ **[TÍNH NĂNG CAO]** Nâng hạng thành viên (Membership Silver/Gold/Platinum) dựa trên điểm.

---

## III. DÀNH CHO CHỦ SHOP (SELLER)
*Trọng tâm: Công cụ bán hàng và quản lý hiệu quả.*

1.  **Quản lý Gian hàng:**
    *   Đăng ký mở shop (Yêu cầu Admin duyệt).
    *   Cấu hình thông tin shop (Tên, Logo, Banner, Mô tả).
2.  **Quản lý Sản phẩm & Kho:**
    *   Đăng sản phẩm mới kèm nhiều hình ảnh.
    *   Quản lý biến thể (Variants): Mỗi sản phẩm có nhiều lựa chọn (Màu/Size) với giá và số lượng kho riêng.
    *   ⭐ **[TÍNH NĂNG CAO]** Tự động cảnh báo khi sản phẩm sắp hết hàng.
3.  **Quản lý Đơn hàng (Seller):**
    *   Duyệt đơn hàng mới.
    *   Cập nhật trạng thái giao hàng (Confirmed -> Delivering -> Delivered).
4.  **Khuyến mãi:**
    *   Tạo Voucher riêng cho Shop (Giảm theo % hoặc số tiền cố định).
    *   ⭐ **[TÍNH NĂNG CAO]** Flash Sale: Thiết lập khung giờ vàng giảm giá kịch sàn cho sản phẩm.
5.  **Thống kê:**
    *   ⭐ **[TÍNH NĂNG CAO]** Dashboard báo cáo doanh số, số đơn hàng theo ngày/tháng bằng biểu đồ (Charts).

---

## IV. DÀNH CHO QUẢN TRỊ VIÊN (ADMIN)
*Trọng tâm: Kiểm soát hệ thống và vận hành sàn.*

1.  **Quản lý Người dùng & Shop:**
    *   Xem danh sách, khóa/mở tài khoản người dùng/người bán.
    *   Phê duyệt yêu cầu mở Shop mới.
2.  **Quản lý Danh mục:**
    *   Quản lý cây danh mục toàn sàn (Thêm/Sửa/Xóa danh mục).
3.  **Quản lý Khuyến mãi toàn sàn:**
    *   Tạo Voucher áp dụng cho tất cả các shop trên sàn (Ví dụ: Voucher FreeShip).
4.  **Báo cáo & Giám sát:**
    *   Xem tổng quan doanh thu toàn sàn.
    *   ⭐ **[TÍNH NĂNG CAO]** Log hệ thống: Theo dõi các hành động quan trọng (Audit Log).

---

## V. CÔNG NGHỆ NỔI BẬT (TECHNICAL HIGHLIGHTS)
*Dành cho giám khảo đánh giá kỹ thuật.*

*   **Frontend:** ReactJS + Vite (Cực nhanh), Ant Design UI, Redux/Context API, WebSocket.
*   **Backend:** Spring Boot 3, Spring Security (JWT), Spring Data JPA.
*   **Database:** SQL Server (Thiết kế chuẩn hóa cao, 23+ bảng).
*   **DevOps:** Dockerize (Chạy dự án chỉ với 1 lệnh Docker Compose).
*   **API:** RESTful API chuẩn hóa, tích hợp Swagger OpenAPI để tra cứu.
