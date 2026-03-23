# 🌟 SỔ TAY VẬN HÀNH DỰ ÁN (E-COMMERCE MARKETPLACE)

> **Dự án:** Hệ thống Thương mại Điện tử Marketplace (Môn: J2EE & CCDC PTPM) \
> **Tech Stack:** Spring Boot (Backend), ReactJS + Vite (Frontend), SQL Server (Database), Docker \
> **Kiến trúc Code:** Monorepo tích hợp Git Submodule

---

## PHẦN 1: TỔNG QUAN KIẾN TRÚC MÃ NGUỒN (MONOREPO)
Dự án được chia làm 3 tầng độc lập nhưng nằm chung trong 1 vỏ bọc:
```text
e_commerce_mini/                  <-- [KHO GỐC] Chỉ chứa cấu hình chung
├── e-commerce-backend/           <-- [SUBMODULE] Code Java Spring Boot 
├── e-commerce-frontend/          <-- [SUBMODULE] Code ReactJS
├── database/                     <-- Chứa script SQL Server
└── docker-compose.yml            <-- Chạy toàn bộ hệ thống
```
**Lưu ý sinh tử:** Các thành viên làm Backend **chỉ** Commit/Push code ở thư mục `e-commerce-backend`. Tương tự với Frontend. KHÔNG sửa code BE/FE ở gốc rồi push mù quáng!

---

## PHẦN 2: THIẾT LẬP MÔI TRƯỜNG & DATABASE
### 2.1. Nhập Database (Chỉ làm 1 lần)
1. Cài đặt **Microsoft SQL Server** và **SSMS**.
2. Mở file `database/init.sql`, copy toàn bộ nội dung, dán vào SSMS và bôi đen bấm `Execute`.
3. Kiểm tra xem Database `ecommerce_marketplace` đã có đủ 23 bảng chưa.

### 2.2. Mở dự án ĐÚNG CÁCH trên IDE
🚫 **TUYỆT ĐỐI KHÔNG:** Mở thư mục gốc `e_commerce_mini` bằng IntelliJ IDEA. IDE sẽ không nhận diện được đây là dự án Java và không tải thư viện Maven.
✅ **CÁCH LÀM ĐÚNG:** 
- Đội Backend: Trong IntelliJ, chọn **File -> Open -> Trỏ vào thư mục `e-commerce-backend`**.
- Đội Frontend: Trong VS Code, mở thư mục `e-commerce-frontend`.

### 2.3. Cấu hình file Môi trường (Environment)
Mỗi máy chủ của các thành viên sẽ có Pass SQL Server khác nhau. 
- **Backend:** copy file `application.yml` (hoặc `application-dev.yml`) và đổi `password: "Pass_SQL_của_bạn"`. Chú ý file này ĐÃ BỊ CHẶN BỞI `.gitignore` nên các bạn tự do sửa pass trên máy mình mà không sợ ảnh hưởng tới máy bạn khác.
- **Frontend:** Tạo file `.env` từ `.env.example` và thiết lập `VITE_API_URL=http://localhost:8080/api`. (Lưu ý: Dùng tiền tố **VITE_** instead of **REACT_APP_**).

---

## PHẦN 3: QUY TRÌNH GIT & SOURCE TREE CHO NHÓM
### Cách lấy code "Submodule" lần đầu
Khi tải code rỗng từ GitHub lần đầu, thư mục BE/FE sẽ trống trơn. Bạn bắt buộc phải mở Terminal/CMD ở thư mục gốc và chạy 1 lệnh duy nhất này để mồi code con về:
```bash
git submodule update --init --recursive
```

### Chuẩn viết Commit (Conventional Commits)
Nhóm quy định mọi dòng Commit phải dùng ngữ pháp Tiếng Anh theo công thức: `<loại>(<phạm-vi>): <mô tả ngắn>`
- `feat: add JWT login API` (Khi tạo thêm chức năng mới)
- `fix: resolve crash on checkout` (Khi sửa một con bug)
- `docs: update README file` (Khi viết tài liệu)
- `refactor: format code in ProductService` (Khi tối ưu lại code cũ nhưng không đổi tính năng)

---

## PHẦN 4: CHIẾN LƯỢC NHÁNH (BRANCHING STRATEGY)
Dự án áp dụng mô hình **Git Flow** đơn giản. Có 2 nhánh cội nguồn không bao giờ được phép xóa:
1. `main`: Chứa code xịn nhất, chỉ dùng để nộp/bảo vệ đồ án.
2. `develop`: Chứa code đang code dở của cả nhóm.

**Quy trình 4 Bước Code Tính Năng Lẻ:**
1. **PULL (Lần 1):** Từ nhánh `develop`, tải code mới nhất của bạn bè về.
2. **BRANCH:** Từ nhánh `develop`, tạo ngay 1 nhánh riêng cho chính bạn. 
   - *Quy tắc đặt tên:* `feature/ten-chuc-nang` (VD: `feature/gio-hang-api`) hoặc `bugfix/ten-loi`.
3. **CODE & COMMIT:** Nhảy sang nhánh `feature/...`, viết code và Commit lại.
4. **SYNC & PUSH:** Thực hiện quy trình ghép code an toàn (Xem chi tiết ở Phần 8) trước khi đẩy lên GitHub.

---

## PHẦN 5: XỬ LÝ CONFLICT (XUNG ĐỘT CODE)
Lỗi này xảy ra khi 2 ông cùng sửa 1 dòng code.
**Cách trị bệnh bằng VS Code / IntelliJ:**
1. Khi bị báo **CONFLICT**, file bị lỗi sẽ hiện chữ Đỏ.
2. Mở file đó ra, IDE sẽ gợi ý 3 lựa chọn:
   - `Accept Current Change`: Lấy code máy bạn.
   - `Accept Incoming Change`: Lấy code của bạn bè.
   - `Accept Both Changes`: Lấy cả 2, tự bạn sửa lại cho hợp lý.
3. Sửa xong -> `git add .` -> `git commit` để kết thúc.

---

## PHẦN 6: LUẬT BẤT THÀNH VĂN CHO BACKEND & DB
1. **KHÔNG XÓA CỨNG (Soft Delete ONLY):**
   - KHÔNG dùng lệnh `DELETE`. Thay vào đó cập nhật `status = 'INACTIVE'`. 
2. **Không trả thẳng Entity rõ rỉ bảo mật:**
   - Phải quăng dữ liệu Entity qua DTO thông qua `mapper`.
3. **Tuyệt đối Không Push "Rác":**
   - Không được push `node_modules`, `target`, `.idea`, `.env` lên GitHub.

---

## PHẦN 7: TOP ĐIỀU NGU NGỐC KHI LÀM ĐỒ ÁN NHÓM
- Thấy code đồng đội ngu, tự ý sửa mà đéo thèm báo. -> **Xóa đi làm lại.**
- Đổi tên file / đổi cấu trúc Database mà không thông báo lên Group Zalo.
- Để rỗng 1 file quá lâu hoặc đẩy code đang lỗi lên nhánh dùng chung.

---

## PHẦN 8: QUY TRÌNH GHÉP CODE (SYNC) AN TOÀN CHO NHÓM 7 NGƯỜI 🛡️
Với nhóm đông (7 người), xác suất xung đột là rất cao. Trước khi `push` code, bắt buộc 7 thành viên phải làm đúng 5 bước:

**1. Giai đoạn chuẩn bị:**
*   Phải `git commit` toàn bộ code của bạn trên nhánh `feature/...` của mình trước.

**2. Giai đoạn lấy code mới (Update Develop Local):**
*   Chuyển về nhánh `develop`: `git checkout develop`
*   Lấy code mới nhất của 6 thành viên còn lại về: `git pull origin develop`

**3. Giai đoạn gộp code (Merge locally):**
*   Quay lại nhánh của bạn: `git checkout feature/ten-cua-bạn`
*   Gộp code mới nhất vào code của mình: `git merge develop`

**4. Giai đoạn Xử lý & Kiểm tra (TỐI QUAN TRỌNG):**
*   Nếu có Xung đột (Conflict): Sửa ngay như hướng dẫn ở Phần 5.
*   **BUILD & RUN:** Mở IntelliJ/VS Code lên, chạy thử Project. Nếu code vẫn lỗi đỏ hoặc bị Crash -> **DỪNG LẠI NGAY**, sửa cho chạy được trên máy mình rồi mới đi tiếp.

**5. Giai đoạn Push & PR:**
*   Khi máy bạn đã chạy mượt cả code của bạn và code của nhóm rồi, gõ: `git push origin feature/ten-cua-bạn`.
*   Lên GitHub tạo **Pull Request (PR)** để Nhóm trưởng duyệt vào `develop`.

> **Ghi nhớ:** Máy bạn chạy được thì code nhóm mới chạy được. Một người đẩy lỗi, 6 người còn lại sẽ bị treo máy!

---

## PHẦN 9: HƯỚNG DẪN CHẠY DỰ ÁN (RUNNING THE PROJECT) 🚀

Sau khi đã thiết lập xong DB và Môi trường, đây là cách để bạn chạy hệ thống lên:

### 9.1. Chạy Backend (Spring Boot)
1. **Mở IntelliJ IDEA:** Trỏ thẳng vào thư mục `e-commerce-backend`.
2. **Đợi Maven tải:** Nhìn góc dưới bên phải, đợi cho tới khi thanh tiến trình (Indexing/Downloading) biến mất.
3. **Run Application:** Tìm file `src/main/java/com/ecommerce/ECommerceApplication.java`, click chuột phải chọn **Run 'ECommerceApplication.main()'**.
4. **Kiểm tra:** Mở trình duyệt gõ: `http://localhost:8080/api/test/hello`. Nếu hiện dòng chữ *"Backend Spring Boot đã sẵn sàng!"* là thành công.

### 9.2. Chạy Frontend (ReactJS + Vite)
1. **Mở Terminal:** Chuyển vào thư mục `e-commerce-frontend`.
2. **Cài đặt thư viện (Chỉ làm 1 lần):** Gõ `npm install`.
3. **Khởi động Dev Server:** Gõ lệnh:
   ```bash
   npm run dev
   ```
4. **Truy cập:** Mở trình duyệt theo địa chỉ hiện ra (thường là `http://localhost:3000`).
5. **Lưu ý:** Dự án đã chuyển từ Webpack sang **Vite** để nhanh và mượt hơn. Không dùng lệnh `npm start` nữa.

---

> Chúc nhóm làm bài tốt và chốt A+! 🚀
