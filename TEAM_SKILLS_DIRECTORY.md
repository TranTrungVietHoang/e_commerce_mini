# 🧠 BỘ KỸ NĂNG & TIÊU CHUẨN CHUNG (TEAM SKILLS DIRECTORY)

Tài liệu này là "Bộ kỹ năng gốc" để 7 thành viên cùng soi chiếu, đảm bảo mọi dòng code đều có chung một "DNA" chất lượng.

---

## I. KỸ NĂNG KỸ THUẬT (CODE SKILLS) - "Viết code sạch"
*Mục tiêu: Đọc code của 7 người thấy giống như 1 người viết.*

1.  **Tiêu chuẩn RESTful API:**
    *   Sử dụng danh từ số nhiều: `/api/v1/products` (Thay vì `/api/v1/getProduct`).
    *   Dùng đúng HTTP Method: `GET` (Lấy), `POST` (Tạo), `PUT` (Sửa), `DELETE` (Xóa).
2.  **Mô hình DTO & Mapper:**
    *   **NGUYÊN TẮC:** Tuyệt đối không trả thẳng Entity (DB) ra FE. Phải qua DTO.
    *   **Mapper:** Dùng `MapStruct` hoặc viết Class thủ công để chuyển đổi (ví dụ: `toDTO`, `toEntity`).
3.  **Xử lý Lỗi tập trung (Global Exception Handling):**
    *   Dùng `@RestControllerAdvice` trong Spring Boot để bắt tất cả các lỗi.
    *   Phản hồi lỗi phải luôn có cấu trúc: `{ "timestamp": "...", "status": 404, "message": "Sản phẩm không tồn tại", "path": "..." }`.
4.  **Validation (Kiểm tra dữ liệu):**
    *   Dùng `@Valid` và `@NotBlank`, `@Min`, `@Max` ở tầng Controller để chặn dữ liệu rác ngay từ cửa ngõ.
5.  **Standard Response Format:** Luôn sử dụng `ApiResponse<T>` cho mọi API để FE dễ dàng bóc tách dữ liệu.

---

## II. TIÊU CHUẨN RÀNG BUỘC (VALIDATION SKILLS) - "Phòng bệnh hơn chữa bệnh"
*Mục tiêu: Đảm bảo dữ liệu trong 23 bảng DB luôn sạch và chính xác.*

### 🛠️ Backend Validation (JSR-303/380)
Tất cả các RequestDTO từ FE gửi lên bắt buộc phải có annotation kiểm tra:
*   **String:** `@NotBlank(message = "...")`, `@Size(min = 8, max = 20, message = "...")`.
*   **Số (Giá tiền/Số lượng):** `@DecimalMin(value = "0.0", inclusive = false, message = "Giá phải lớn hơn 0")`.
*   **Email:** `@Email(message = "Email không hợp lệ")`.
*   **Ngày tháng:** `@FutureOrPresent` (cho Voucher), `@Past` (cho ngày sinh).

### 🎨 Frontend Validation (Ant Design Rules)
Tất cả các Form của Ant Design phải có thuộc tính `rules` tương ứng với Backend:
*   `required: true`: Bắt buộc nhập.
*   `pattern`: Chặn định dạng số điện thoại/email bằng Regex ngay tại trình duyệt.
*   **Logic chéo:** Sử dụng `dependencies` trong Form để kiểm tra: "Ngày kết thúc phải sau ngày bắt đầu".

---

## III. KỸ NĂNG TRỢ LÝ AI (AI ASSISTANT SKILLS) - "Cộng tác với AI"
*Mục tiêu: Tối ưu hóa việc dùng AI (như Antigravity/Cursor/Copilot) để code nhanh hơn.*

1.  **Cung cấp Context Đầy đủ:**
    *   Trước khi bảo AI code tính năng mới, hãy copy nội dung file `init.sql` và `TEAM_TASK_ASSIGNMENT.md` vào câu lệnh đầu tiên để AI hiểu đúng bảng dữ liệu.
2.  **Prompt Tiêu chuẩn cho dự án này:**
    *   *"Dựa trên file init.sql, hãy viết cho tôi bộ CRUD cho bảng [Tên Bảng], sử dụng Spring Boot 3, JPA, và trả về DTO theo cấu trúc chuẩn của dự án."*
3.  **Kiểm tra chéo (AI Verification):**
    *   Sau khi AI viết xong, hãy bảo nó: *"Hãy phân tích lỗ hổng bảo mật hoặc lỗi logic trong đoạn code này dựa trên quy chuẩn Marketplace."*

---

## III. KỸ NĂNG QUY TRÌNH (WORKFLOW SKILLS) - "Hệ thống vận hành"
*Mục tiêu: Kiểm soát rủi ro khi làm việc nhóm đông.*

1.  **Skill "Code Review" (Tối quan trọng):**
    *   Nhóm trưởng/Thành viên 1 phải xem code của bạn khác ít nhất 5 phút trước khi bấm Merge.
    *   Kiểm tra: Đặt tên biến có đúng quy định không? Code có bị lặp (DRY) không?
2.  **Skill "Sync Code":**
    *   Cứ sau 2 tiếng Code, hãy `git pull` nhánh `develop` một lần để tránh việc "code của mình bị trôi quá xa so với thực tế".
3.  **Skill "Daily Standup":**
    *   Mỗi ngày dành 5 phút trên Zalo: "Hôm qua làm được gì?", "Hôm nay định làm gì?", "Có đang bị nghẽn (Block) chỗ nào không?".

---

## V. KỸ NĂNG DEBUG & XỬ LÝ SỰ CỐ (DEBUGGING SKILLS) - "Bắt bệnh cho Code"
*Mục tiêu: Tìm ra lỗi trong 30 giây thay vì 3 tiếng.*

1.  **Frontend Debugging (F12):**
    *   **Network Tab:** Xem API trả về lỗi 400, 403 (Quyền) hay 500 (Lỗi Serve). Kiểm tra "Response" để thấy thông báo lỗi từ Java.
    *   **Console Tab:** Bắt các lỗi JavaScript/React làm treo màn hình.
2.  **Backend Debugging:**
    *   **Spring Logs:** Xem Terminal của IntelliJ. Mọi lỗi SQL hay Logic đều hiện đỏ ở đây.
    *   **Postman:** Luôn test API bằng Postman trước khi gẩy vào React để chắc chắn BE đã chạy đúng.

---

## VI. KỸ NĂNG TỐI ƯU HIỆU NĂNG (PERFORMANCE SKILLS) - "Chạy nhanh và mượt"
*Mục tiêu: Đạt điểm tối đa về hiệu năng khi nộp đồ án.*

1.  **Tối ưu Database (SQL):**
    *   Yêu cầu Thành viên làm DB thêm `INDEX` cho các trường hay dùng để tìm kiếm như `product_name`, `slug`, `category_id`.
2.  **Tối ưu Frontend:**
    *   **Lazy Loading:** Chỉ tải ảnh khi người dùng cuộn tới nơi (Ant Design hỗ trợ sẵn).
    *   **Assets:** Nén ảnh sản phẩm trước khi upload để trang web không bị nặng.

---

## VII. TIÊU CHUẨN GIAO DIỆN (UI/UX SKILLS) - "Đẹp và đồng nhất"
*Mục tiêu: Không để 7 trang web nhìn khác nhau hoàn toàn.*

1.  **Bảng màu (Color Palette):**
    *   Màu chính (Primary): `#1677ff` (Màu xanh AntD mặc định).
    *   Màu lỗi (Danger): `#ff4d4f`.
2.  **Khoảng cách (Spacing):**
    *   Dùng chuẩn bội số của 8 (Margin/Padding: 8px, 16px, 24px, 32px) để bố cục nhìn cân đối.
3.  **Responsive:**
    *   Luôn kiểm tra giao diện trên Mobile (dùng F12 -> Toggle Device Toolbar). Chợ mạng người dùng chủ yếu dùng điện thoại!

---

## VIII. BỘ TIỆN ÍCH DÙNG CHUNG (COMMON UTILITIES) - "Vũ khí tập thể"
*Đây là những thứ nhóm nên xây dựng ngay trong tuần đầu tiên để dùng chung.*

### 🛠️ Backend (Java Utils)
1.  **`ApiResponse<T>`:** Lớp bọc kết quả trả về cho FE.
    ```java
    public class ApiResponse<T> {
        private int code;      // 200, 400, 500
        private String message;
        private T result;      // Dữ liệu thực tế
    }
    ```
2.  **`SecurityUtils`:** Các hàm lấy User ID của người đang đăng nhập từ Security Context.
3.  **`UploadService`:** Hàm dùng chung để đẩy ảnh lên bộ nhớ (Cloudinary/S3).
4.  **`FormatUtils`:** Định dạng tiền tệ VNĐ và thời gian (Pattern: `dd/MM/yyyy HH:mm:ss`).

### 📦 Frontend (ReactJS Utils)
1.  **`api.config.js`:** Cấu hình Axios với Interceptor để tự động đính kèm Token vào Header.
2.  **`AuthContext`:** Lưu trữ trạng thái đăng nhập (User info, Role) cho toàn bộ App.
3.  **`PriceDisplay`:** Component hiển thị giá tiền (Ví dụ: 1.500.000đ) với màu sắc nổi bật.
4.  **`NotificationHelper`:** Hàm dùng chung để hiện thông báo thành công/thất bại (antd `message`/`notification`).

---

> **LỜI NHẮN CHO NHÓM:** "Đi nhanh thì đi một mình, đi xa thì đi cùng nhau". Bộ Skills này chính là thứ gắn kết 7 người lại thành một khối thống nhất! 🚀
