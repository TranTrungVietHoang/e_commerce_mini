# 🐳 HƯỚNG DẪN TRIỂN KHAI DOCKER (DOCKER DEPLOYMENT GUIDE)

Tài liệu này hướng dẫn bạn từng bước cách "đóng gói" mã nguồn thành một Docker Image, cách chạy thử (Container) và cách đẩy lên đám mây (Docker Hub) để bất kỳ ai cũng có thể tải về chạy được.

---

## 🏗️ BƯỚC 1: VIẾT DOCKERFILE

Để đóng gói ứng dụng, bạn cần tạo một tệp tin rỗng không có đuôi mở rộng, đặt tên chính xác là `Dockerfile` ở thư mục gốc của dự án (hoặc thư mục con nếu bạn muốn đóng riêng). Dưới đây là 2 kịch bản thường gặp nhất trong dự án của bạn.

### Kịch bản A: Đóng gói Backend (Spring Boot)
File này sẽ giúp biên dịch code Java bằng Maven, sau đó gói file `.jar` vào một hệ điều hành Linux siêu nhẹ (Alpine) đã cài sẵn Java.

*   Tạo file `Dockerfile` trong thư mục `e-commerce-backend`:

```dockerfile
# Stage 1: Build file .jar bằng Maven
FROM maven:3.9.5-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
# Build bỏ qua test để tiết kiệm thời gian
RUN mvn clean package -DskipTests

# Stage 2: Đẩy file .jar vào môi trường chạy thực tế
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
# Lấy file .jar ở Stage 1 sang Stage 2
COPY --from=builder /app/target/*.jar app.jar
# Mở cổng 8080 cho Backend
EXPOSE 8080
# Lệnh chạy ứng dụng khi container khởi động
ENTRYPOINT ["java", "-jar", "app.jar"]
```

### Kịch bản B: Đóng gói Frontend (React Vite + Nginx)
File này sẽ build mã nguồn React ra HTML/CSS tĩnh, sau đó dùng Nginx (một máy chủ web) để phục vụ các file này.

*   Tạo file `Dockerfile` trong thư mục `e-commerce-frontend` (Xóa nội dung file cũ nếu có):

```dockerfile
# Stage 1: Cài đặt node_modules và build dự án
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Phục vụ file bằng Nginx
FROM nginx:alpine
# Xóa cấu hình mặc định của Nginx
RUN rm -rf /usr/share/nginx/html/*
# Lấy thư mục dist/ (kết quả build của Vite) sang thư mục của Nginx
COPY --from=builder /app/dist /usr/share/nginx/html
# Copy file cấu hình điều hướng Nginx tùy chỉnh vào
COPY nginx.conf /etc/nginx/conf.d/default.conf
# Mở cổng 80 cho Nginx
EXPOSE 80
# Chạy Nginx ở chế độ background
CMD ["nginx", "-g", "daemon off;"]
```

---

## 🛠️ BƯỚC 2: TẠO DOCKER IMAGE (`docker build`)

Docker Image giống như một bản cài đặt game (`.iso` hoặc `.exe`). Nó chứa toàn bộ mã nguồn, thư viện và hệ điều hành cần thiết để không bị lỗi "máy tôi chạy được nhưng máy bạn thì không".

*   **Cấu trúc lệnh:** `docker build -t <ten_docker_hub_cua_ban>/<ten_image>:<tag_version> .`
*   **Lưu ý:** Dấu `.` ở cuối lệnh mang ý nghĩa là "tìm file `Dockerfile` ở thư mục hiện tại".

### Bắt đầu thao tác (Ví dụ với Backend):
1.  Mở Terminal và truy cập vào thư mục backend: `cd e-commerce-backend`
2.  Chạy lệnh Build (Giả sử tài khoản Docker Hub của bạn là *trantrungviethoang*):
    ```bash
    docker build -t trantrungviethoang/e-commerce-backend:v1.0 .
    ```
3.  Hãy lấy một tách cà phê và chờ hệ thống tải các thư viện về đóng gói.
4.  Sau khi xong, gõ `docker images` để kiểm tra, bạn sẽ thấy Image của mình đã nằm gọn trong máy tính.

---

## 🚀 BƯỚC 3: CHẠY DOCKER CONTAINER (`docker run`)

Docker Container chính là việc bạn "nhấp đúp" vào file Image để chạy nó. Nó là một tiến trình đang hoạt động độc lập trên máy của bạn.

*   **Lệnh chạy (Có kèm bảo mật):**
    ```bash
    docker run -d -p 8080:8080 \
      --name backend-api \
      -e DB_USERNAME=sa \
      -e DB_PASSWORD=MatKhauThatCủaBạn \
      trantrungviethoang/e-commerce-backend:v1.0
    ```
*   **Giải thích các cờ lệnh (Flags):**
    *   `-d`: (Detached) Cho phép container chạy ngầm.
    *   `-p 8080:8080`: Link cổng máy thật và container.
    *   `-e`: (Environment) Truyền biến môi trường vào container (Rất quan trọng để kết nối DB).
    *   `--name backend-api`: Đặt tên dễ nhớ.
*   **Giám sát:**
    *   Gõ `docker ps` để xem trạng thái.
    *   Gõ `docker logs backend-api` để xem nhật ký.
    *   Truy cập `http://localhost:8080/api/test/hello`.

---

## ☁️ BƯỚC 4: ĐẨY LÊN DOCKER HUB (`docker push`)

Đây là bước để bạn lưu trữ Image vĩnh viễn và chia sẻ nó cho bất kỳ ai (điều kiện cần khi đi xin việc/ nộp đồ án cho thầy cô xem).

1.  **Đăng nhập vào Docker (Chỉ làm 1 lần):**
    ```bash
    docker login
    ```
    Hệ thống sẽ hỏi Username và Password trên trang https://hub.docker.com của bạn.

2.  **Đẩy Image lên Đám mây:**
    ```bash
    docker push trantrungviethoang/e-commerce-backend:v1.0
    ```
    *(Tên image phải trùng chính xác với tên bạn đã tạo ở lệnh `docker build` Bước 2).*

---

## 📦 BƯỚC 5: SỬ DỤNG DOCKER COMPOSE (QUẢN LÝ NHIỀU CONTAINER) 🚀

Thay vì gõ từng lệnh cho Backend và Frontend, bạn có thể dùng file **`docker-compose.yml`** để điều khiển cả nhóm cùng lúc.

1.  **Cấu hình file `docker-compose.yml` (Đã được tạo ở thư mục gốc):**
    File này khai báo cả 2 dịch vụ (Backend và Frontend) kèm hình ảnh tương ứng trên Docker Hub.

2.  **Lệnh Build & Push hàng loạt (Chỉ dùng khi sửa cả 2):**
    Tại thư mục gốc, gõ:
    ```bash
    # Build tất cả
    docker-compose build

    # Push tất cả lên Docker Hub cùng lúc
    docker-compose push
    ```

3.  **Lệnh Khởi chạy tất cả (Nhanh nhất):**
    ```bash
    docker-compose up -d
    ```
    *   **Tác dụng:** Docker tự động bật Backend ở cổng 8080, Frontend ở cổng 3000. Bạn không cần làm gì thêm!

4.  **Lệnh Dừng tất cả:**
    ```bash
    docker-compose down
    ```

---

> **LỜI KHUYÊN:** Khi làm việc nhóm, bạn chỉ cần gẩy file `docker-compose.yml` này cho bạn bè. Họ chỉ cần gõ đúng 1 dòng `docker-compose up -d` là toàn bộ dự án của bạn sẽ chạy lên mượt mà trên máy của họ! 🎈
