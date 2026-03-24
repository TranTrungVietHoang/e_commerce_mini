# 🛡️ HƯỚNG DẪN THIẾT LẬP NHÁNH & QUY TẮC BẢO VỆ (GIT PROTECTION)

Để đảm bảo code của 7 người không bị "loạn", bạn cần thiết lập nhánh `develop` và cấu hình luật trên GitHub.

---

## BƯỚC 1: TẠO NHÁNH `develop` (Làm trên máy Nhóm trưởng)

Bạn cần mở Terminal ở từng thư mục và chạy lệnh sau để tạo và đẩy nhánh lên GitHub:

### 1.1. Cho Repo Tổng (Root):
```bash
git checkout -b develop
git push origin develop
```

### 1.2. Cho Backend:
```bash
cd e-commerce-backend
git checkout -b develop
git push origin develop
cd ..
```

### 1.3. Cho Frontend:
```bash
cd e-commerce-frontend
git checkout -b develop
git push origin develop
cd ..
```

---

## BƯỚC 2: CẤU HÌNH LUẬT TRÊN GITHUB (QUAN TRỌNG)

Bạn phải thực hiện việc này trên giao diện Web của **GitHub** -> **Settings** -> **Rules** -> **Rulesets** cho **cả 3 Repository** (Root, BE, FE).

### 2.1. Cấu hình nhánh `develop` (Yêu cầu Review)
1. Bấm **New branch ruleset**, đặt tên `protect_develop`.
2. **Target branches:** Thêm mục tiêu (*Add target*) -> Chọn *Include by pattern* -> Gõ `develop`.
3. **Bypass list:** Thêm ngoại lệ (*Add bypass*) -> Chọn *Repository admin* (Chính là bạn).
4. **Rules:**
   - Tích chọn **Restrict deletions** (Không ai được xóa nhánh).
   - Tích chọn **Require a pull request before merging** -> Chọn *Required approvals = 1*.
   - Tích chọn **Block force pushes**.

### 2.2. Cấu hình nhánh `main` (Khóa cứng chuyên nghiệp)
1. Bấm **New branch ruleset**, đặt tên `protect_main`.
2. **Target branches:** Chọn *Include by pattern* -> Gõ `main`.
3. **Bypass list:** Thêm ngoại lệ (*Add bypass*) -> Chọn *Repository admin* (Chính là bạn). Đây là chìa khóa để chỉ bạn thao tác được.
4. **Rules:**
   - Tích chọn **Restrict updates** (Khóa toàn bộ việc Push/Merge từ các thành viên khác).
   - Tích chọn **Restrict deletions**.
   - Tích chọn **Require a pull request before merging**.
   - Tích chọn **Block force pushes**.

---

## BƯỚC 3: QUY TRÌNH LÀM VIỆC DÀNH CHO THÀNH VIÊN

Sau khi bạn thiết lập xong, 6 thành viên còn lại sẽ làm việc như sau:
1. Code trên nhánh cá nhân (ví dụ: `feature/login`).
2. Khi xong, đẩy lên GitHub: `git push origin feature/login`.
3. Lên GitHub tạo **Pull Request (PR)**: Target là nhánh `develop`.
4. **Nhóm trưởng (Bạn)** vào kiểm tra code -> Nếu OK thì bấm **Approve** và **Merge**.

> **Ghi chú:** Việc này giúp bạn kiểm soát 100% chất lượng code trước khi nó được đưa vào hệ thống chung. 🚀
