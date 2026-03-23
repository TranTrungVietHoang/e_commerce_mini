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

Bạn phải thực hiện việc này trên giao diện Web của GitHub cho **cả 3 Repository** (Root, BE, FE).

### 2.1. Cấu hình nhánh `develop` (Yêu cầu Review)
1. Vào **Settings** -> **Branches**.
2. Tại mục **Branch protection rules**, bấm **Add rule**.
3. **Branch name pattern:** Gõ `develop`.
4. Tích chọn **Require a pull request before merging**.
5. Tích chọn **Require approvals** và chọn số lượng là `1` (Chính là bạn - Nhóm trưởng).
6. Tích chọn **Restrict who can push to matching branches** (Chỉ cho phép Nhóm trưởng).

### 2.2. Cấu hình nhánh `main` (Khóa cứng)
1. Bấm **Add rule** mới.
2. **Branch name pattern:** Gõ `main`.
3. Tích chọn **Lock branch** (Read-only) HOẶC Tích chọn **Restrict who can push to matching branches** và chỉ điền tên của bạn.
4. Điều này đảm bảo không ai được phép đẩy code lung tung lên `main` trừ khi bạn gộp code từ `develop` lên.

---

## BƯỚC 3: QUY TRÌNH LÀM VIỆC DÀNH CHO THÀNH VIÊN

Sau khi bạn thiết lập xong, 6 thành viên còn lại sẽ làm việc như sau:
1. Code trên nhánh cá nhân (ví dụ: `feature/login`).
2. Khi xong, đẩy lên GitHub: `git push origin feature/login`.
3. Lên GitHub tạo **Pull Request (PR)**: Target là nhánh `develop`.
4. **Nhóm trưởng (Bạn)** vào kiểm tra code -> Nếu OK thì bấm **Approve** và **Merge**.

> **Ghi chú:** Việc này giúp bạn kiểm soát 100% chất lượng code trước khi nó được đưa vào hệ thống chung. 🚀
