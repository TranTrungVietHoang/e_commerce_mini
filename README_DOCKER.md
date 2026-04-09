# Hướng dẫn Khởi chạy Hệ thống bằng Docker (Dành cho thành viên team)

Dự án này đã được tích hợp toàn bộ **SQL Server 2022** và **Backend/Frontend** vào hệ thống Docker Compose. Nhờ đó, bạn không cần phải cài đặt thủ công SQL Server hay thay đổi cấu hình loằng ngoằng, chỉ bằng một vài thao tác là hệ thống tự động chạy.

Dưới đây là các bước yêu cầu bạn phải thiết lập môi trường CẨN THẬN để kết nối với cơ sở dữ liệu.

---

## BƯỚC 1: Khởi tạo biến môi trường (BẮT BUỘC)

Trong dự án này, hệ thống sẽ sử dụng **2 file `.env`** ở 2 cấp thư mục khác nhau. Bạn bắt buộc phải tạo đủ cả hai file này.

### 1. File `.env` thứ nhất ở Thư mục gốc (Root)
Tạo một file `.env` nằm ngang hàng với file `docker-compose.yml` (nếu chưa có).
Nội dung file này **phải có**:

```env
# Mật khẩu khởi tạo cho SQL Server bên trong Docker
# Mật khẩu TỐI THIỂU 8 KÝ TỰ, PHẢI BAO GỒM CHỮ HOA, CHỮ THƯỜNG, SỐ VÀ KÝ TỰ ĐẶC BIỆT
DB_PASSWORD=YourStrong@Passw0rd
```
*(Đây là mật khẩu mà `docker-compose` sẽ dùng để boot máy chủ SQL Server và là cầu nối cho Backend.)*

### 2. File `.env` thứ hai ở bên trong Backend (`e-commerce-backend/.env`)
Đi vào thư mục `e-commerce-backend`. Bạn sẽ thấy một file tên là `.env.example`.
Hãy copy file đó thành file có tên `.env` (hoặc đổi tên file đó thành `.env`).

Trong file này chứa toàn bộ các thông tin kết nối dịch vụ ngoài:
- `JWT_SECRET`: Khóa bí mật dùng cho bảo mật Đăng nhập.
- `CLOUDINARY_URL`: Key dùng cho hệ thống Upload ảnh sản phẩm.
- Các biến liên quan tới Server (Bạn có thể bỏ qua phần Database nếu đã thiết lập ở Root).

---

## BƯỚC 2: Khởi động hệ thống Docker

Sau khi file `.env` đã nằm vào đúng vị trí của nó, mở Terminal / PowerShell ở thư mục Root (chứa `docker-compose.yml`) và chạy dòng lệnh sau:

```bash
docker-compose up -d --build
```

**Các dịch vụ sẽ chạy bao gồm:**
*   `sqlserver`: Máy chủ cơ sở dữ liệu SQL Server (Chạy ở Port `1434` ra bên ngoài máy thật).
*   `backend`: Máy chủ Spring Boot (Chạy ở Port `8080`).
*   `frontend`: Nền tảng ReactJS App (Chạy ở Port `3000`).

---

## 🛠 Những Lưu ý và Lỗi Thường Gặp (Troubleshooting)

1. **Lỗi "Ports are not available..." cổng 3000**:
   - *Nguyên nhân:* Do bạn đang mở Frontend chạy thủ công bằng lệnh `npm run dev` ở bên ngoài.
   - *Giải quyết:* Hãy ấn `Ctrl + C` tắt trình chạy node đó đi rồi hẵng bật docker, hoặc chạy docker chỉ với Backend và Database: `docker-compose up -d sqlserver backend`.

2. **Lỗi 500 do Database "bị chết cứng" không tự Reset**:
   - Nếu bạn thay đổi Class ở Java/Hibernate mà bị Crash, đừng xóa Data bằng tay.
   - Hạ hệ thống xuống hoàn toàn: `docker-compose down -v` (Cảnh báo: lệnh `-v` sẽ xóa vĩnh viễn dữ liệu Database cũ đang lưu trong Docker, làm sạch lại như mới).
   - Khởi động lại: `docker-compose up -d`.

3. **Backend không khởi động kịp SQL Server**:
   - Đôi khi Java chạy nhanh hơn CSDL khởi động. Docker Compose sẽ báo lỗi kết nối và tự động khởi động lại (restart: always) Backend 1-2 lần để kết nối đến khi được. Đừng vội lo lắng!
