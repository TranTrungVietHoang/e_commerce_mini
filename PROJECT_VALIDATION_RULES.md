# 🛡️ MA TRẬN RÀNG BUỘC DỮ LIỆU CHI TIẾT (EXHAUSTIVE VALIDATION MATRIX)

Tài liệu này tập trung hoàn toàn vào **Nghiệp vụ (Logic)** và các kịch bản lỗi có thể xảy ra cho từng trường thông tin trong 23+ bảng dữ liệu của dự án.

---

## I. HỆ THỐNG TÀI KHOẢN (AUTH & USERS)

| Trường dữ liệu | Kịch bản lỗi (Input Sai) | Kết quả xử lý / Ràng buộc |
| :--- | :--- | :--- |
| **Username** | Để trống | Báo lỗi: "Tên đăng nhập không được để trống". |
| | Ít hơn 5 ký tự | Báo lỗi: "Tên đăng nhập phải từ 5-50 ký tự". |
| | Chứa ký tự đặc biệt (@, #, !) | Chặn ngay lập tức, chỉ cho phép chữ cái và số. |
| | Đã tồn tại trong hệ thống | Báo lỗi: "Tên đăng nhập đã được sử dụng". |
| **Email** | Sai định dạng (thiếu @ hoặc .) | Báo lỗi: "Email không đúng định dạng". |
| | Đã tồn tại trong hệ thống | Báo lỗi: "Email này đã được đăng ký". |
| **Password** | Ít hơn 8 ký tự | Báo lỗi: "Mật khẩu quá ngắn (Yêu cầu ít nhất 8 ký tự)". |
| | Thiếu chữ hoa/số/ký tự đặc biệt | Yêu cầu độ phức tạp: 1 hoa, 1 thường, 1 số, 1 ký tự đặc biệt. |
| | Không khớp (khi Repassword) | Báo lỗi: "Mật khẩu xác nhận không khớp". |
| **Số điện thoại** | Không đủ 10 chữ số | Chặn ngay, báo lỗi: "SĐT phải có đúng 10 chữ số". |
| | Không thuộc đầu số VN | Chỉ cho phép đầu số: 03, 05, 07, 08, 09. |

---

## II. GIAN HÀNG & DANH MỤC (SHOPS & CATEGORIES)

| Trường dữ liệu | Kịch bản lỗi (Input Sai) | Kết quả xử lý / Ràng buộc |
| :--- | :--- | :--- |
| **Tên Shop** | Để trống hoặc < 5 ký tự | Báo lỗi: "Tên shop quá ngắn". |
| | Trùng tên Shop đã có | Chặn tạo mới, yêu cầu đổi tên khác. |
| **Slug (URL)** | Chứa dấu cách hoặc chữ viết hoa | Tự động chuyển thành chữ thường và nối bằng dấu gạch ngang (-). |
| | Nhập ký tự có dấu (Tiếng Việt) | Báo lỗi: "URL không được chứa dấu Tiếng Việt". |
| **Duyệt Shop** | Admin chưa duyệt | Trạng thái mặc định: PENDING. Shop không được đăng bán hàng. |

---

## III. SẢN PHẨM & BIẾN THỂ (PRODUCTS & VARIANTS)

| Trường dữ liệu | Kịch bản lỗi (Input Sai) | Kết quả xử lý / Ràng buộc |
| :--- | :--- | :--- |
| **Tên Sản phẩm** | Dưới 10 ký tự | Báo lỗi: "Tên sản phẩm phải từ 10-200 ký tự". |
| **Giá Sản phẩm** | **Nhập chữ/ký tự lạ** | **Chặn nhập ngay từ bàn phím, ô nhập không hiển thị chữ.** |
| | Giá <= 0 | Báo lỗi: "Giá sản phẩm phải lớn hơn 0". |
| | Giá quá cao (vô lý) | Giới hạn tối đa (ví dụ: 1 tỷ VNĐ) để tránh lỗi dữ liệu. |
| **Tồn kho (Stock)** | Nhập số âm | Tự động chuyển về 0 hoặc báo lỗi: "Kho không được âm". |
| | **Nhập chữ** | **Ô nhập số không nhận ký tự chữ.** |
| **Biến thể (Variant)**| Trùng thuộc tính | Ví dụ: 2 variant cùng là "Đỏ - Size M" -> Chặn, báo lỗi: "Biến thể này đã tồn tại". |
| | Thiếu ảnh đại diện | Báo lỗi: "Mỗi sản phẩm/biến thể cần ít nhất 1 hình ảnh". |

---

## IV. GIỎ HÀNG & KHUYẾN MÃI (CART & VOUCHERS)

| Trường dữ liệu | Kịch bản lỗi (Input Sai) | Kết quả xử lý / Ràng buộc |
| :--- | :--- | :--- |
| **Thêm vào giỏ** | Số lượng > Tồn kho | Báo lỗi: "Trong kho chỉ còn [X] sản phẩm". |
| | Số lượng = 0 | Tự động xóa khỏi giỏ hoặc báo lỗi: "Tối thiểu là 1". |
| **Áp dụng Voucher**| Mã không tồn tại | Báo lỗi: "Mã giảm giá không hợp lệ". |
| | Đã hết hạn sử dụng | Báo lỗi: "Mã giảm giá này đã hết hạn". |
| | Chưa đủ điều kiện (Min Spend)| Báo lỗi: "Đơn hàng phải từ [X] VNĐ để dùng mã này". |
| | Đã hết lượt sử dụng | Báo lỗi: "Mã giảm giá đã dùng hết". |

---

## V. ĐẶT HÀNG & THANH TOÁN (ORDER & CHECKOUT)

| Trường dữ liệu | Kịch bản lỗi (Input Sai) | Kết quả xử lý / Ràng buộc |
| :--- | :--- | :--- |
| **Địa chỉ nhận hàng**| Để trống hoặc quá ngắn | Báo lỗi: "Vui lòng nhập đầy đủ địa chỉ giao hàng". |
| **Thanh toán** | Chưa chọn PT thanh toán | Chặn nút "Đặt hàng", báo: "Vui lòng chọn phương thức thanh toán". |
| **Trạng thái đơn** | Seller hủy đơn đã giao | Chặn logic: Đơn đã THÀNH CÔNG không được phép HỦY. |
| **Update kho** | Đặt hàng thành công | Tự động trừ số lượng tồn kho tương ứng của Variant đó. |

---

## VI. TƯƠNG TÁC (REVIEWS & CHAT)

| Trường dữ liệu | Kịch bản lỗi (Input Sai) | Kết quả xử lý / Ràng buộc |
| :--- | :--- | :--- |
| **Gửi Review** | Chưa mua hàng | Chặn nút Review: "Chỉ khách đã mua hàng mới được đánh giá". |
| | Rating < 1 hoặc > 5 | Chặn logic, chỉ cho phép chọn từ 1 đến 5 sao. |
| | Review rỗng | Báo lỗi: "Vui lòng nhập nội dung đánh giá". |
| **Gửi Chat** | Tin nhắn quá dài | Chặn ở ký tự 1000. |

---

> **KẾT LUẬN:** Đây là bộ quy tắc bao quát mọi góc khuất của hệ thống. 7 thành viên dựa vào bảng này để code logic BE và FE, đảm bảo hệ thống không bao giờ bị "crash" do dữ liệu sai. 🚀
