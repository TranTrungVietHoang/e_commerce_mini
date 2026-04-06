# E-Commerce Mini Project

Dự án Hệ thống Thương mại Điện tử Đa người dùng (Multi-Vendor E-commerce).

---

## 📱 Danh Sách Các Màn Hình Frontend Cần Thiết (UI/UX Requirements)

Để ứng dụng E-commerce hoạt động đầy đủ chức năng và khớp với luồng API của thư mục `e-commerce-backend`, bộ phận Frontend (ReactJS/VueJS) cần xây dựng các màn hình dưới đây, phân bổ theo từng vai trò (Role):

### 1️⃣ Nhóm Màn Hình Khách Vãng Lai (Guest & Public)
Đây là các giao diện bất kỳ ai cũng có thể vào xem mà không cần phải có tài khoản.
- [ ] **Màn hình Trang chủ (Home Page):** Hiển thị Banner quảng cáo, Danh mục nổi bật, Flash Sale và các Sản phẩm mới nhất.
- [ ] **Màn hình Tìm kiếm & Danh sách Sản phẩm (Product Discovery):** Gọi thẻ hiển thị sản phẩm, bộ lọc (filter theo giá, danh mục, từ khóa).
- [ ] **Màn hình Chi tiết Sản phẩm (Product Detail):** Xem đầy đủ mô tả, hình ảnh (carousel), chọn Biến thể (Size/Màu sắc), số lượng, và nút "Thêm vào giỏ/Mua ngay".
- [ ] **Màn hình Cửa hàng (Shop/Storefront Profile):** Giao diện khi người dùng bấm vào xem trang chủ của một cửa hàng cụ thể (thấy Logo shop, mô tả, danh sách hàng của shop đó).

### 2️⃣ Nhóm Màn Hình Khách Hàng (Customer)
Yêu cầu phải Đăng nhập (có Token).
- [ ] **Màn hình Xác thực (Auth):**
  - Form Đăng nhập (Login).
  - Form Đăng ký (Register).
- [ ] **Màn hình Giỏ Hàng (Cart Detail):** Liệt kê các sản phẩm đã chọn, thay đổi số lượng (+/-) và tính nháp tổng tiền (Subtotal).
- [ ] **Màn hình Thanh toán (Checkout):** Nhập thông tin người nhận hàng (Tên, SĐT, Địa chỉ), chọn phương thức thanh toán (COD / Chuyển khoản), mã giảm giá.
- [ ] **Màn hình Lịch sử Đơn hàng (My Orders):** Theo dõi quá trình vận đơn (Chờ Xác Nhận -> Đang Giao -> Hoàn Tất).
- [ ] **Màn hình Hồ sơ Cá nhân (User Profile):** Cập nhật Avatar, thông tin liên lạc và Đổi mật khẩu.

### 3️⃣ Nhóm Màn Hình Kênh Người Bán (Seller Dashboard)
Khu vực dành riêng cho chủ shop quản lý buôn bán (Route Guard: `ROLE_SELLER`).
- [ ] **Màn hình Đăng ký / Chỉnh sửa Kênh Bán Hàng:** Nếu tài khoản chưa lập shop, màn hình này sẽ hiện ra yêu cầu khai báo Tên Shop và Mô tả.
- [ ] **Màn hình Tổng quan Cửa hàng (Dashboard):** Biểu đồ doanh thu hoặc các con số tóm tắt thống kê.
- [ ] **Màn hình Quản lý Sản phẩm (Products Management):** 
  - Bảng danh sách sản phẩm của shop.
  - Form Thêm/Sửa sản phẩm phức tạp (Upload nhiều ảnh, thêm các Variant thuộc tính kèm giá và số lượng kho).
- [ ] **Màn hình Quản lý Đơn hàng của Khách (Shop Orders):** Xem khách nào đã đặt hàng shop mình, thao tác Cập nhật Trạng Thái Giao Hàng (Xác nhận Đơn -> Bắt đầu Giao).
- [ ] **Màn hình Quản lý Kho & Khuyến Mãi (Inventory & Flash Sale):** Cập nhật giá giảm, số lượng tồn kho theo thời gian thực.

### 4️⃣ Nhóm Màn Hình Quản Trị Hệ Thống (Admin Portal)
Khu vực của ban điều hành cao nhất bảo vệ sàn đấu giá (Route Guard: `ROLE_ADMIN`).
- [ ] **Màn hình Thống kê Sàn (Admin Dashboard):** Bảng số liệu tình hình kinh doanh toàn hệ thống.
- [ ] **Màn hình Kiểm duyệt Gian Hàng & Sản phẩm (Moderation):** 
  - Danh sách các sản phẩm đang chờ duyệt (`PENDING`). 
  - Admin bấm `APPROVE` (Cho phép hiển thị lên Trang chủ) hoặc `REJECT` (Từ chối).
- [ ] **Màn hình Quản lý Người dùng (Users):** Quản lý danh sách tài khoản, hỗ trợ khóa tài khoản vi phạm (Ban/Block).
- [ ] **Màn hình Quản lý Cấu trúc Data:** Cập nhật/Thêm/Xóa các Danh mục Sản phẩm (Categories) của toàn bộ hệ thống.

---
*Ghi chú cho Team Frontend:* Vui lòng import file `E-Commerce-Mini-Postman.json` vào Postman để đảm bảo Payload gởi lên API đúng khớp 100% với tên gọi của dữ liệu ở các Form.
