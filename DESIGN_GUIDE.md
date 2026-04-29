# 📱 Hướng Dẫn Thiết Kế App - TIÊN SƠN Quản Lý Cân Xe

## 🎯 Tổng Quan Dự Án
App mobile quản lý phòng cân và báo cáo sản lượng xi măng cho công ty TIÊN SƠN.

---

## 🎨 Bộ Màu Chính

| Tên | Mã Hex | Sử Dụng | Mô Tả |
|-----|--------|--------|--------|
| **Primary Blue** | `#0052cc` | Nút chính, header, thông tin | Xanh dương chuyên nghiệp |
| **Primary Dark** | `#003d99` | Hover/active button | Xanh dương đậm |
| **Primary Light** | `#e3f2fd` | Info box, background | Xanh dương nhạt |
| **Success Green** | `#22c55e` | Status "Hoàn thành" | Xanh lá thành công |
| **Warning Yellow** | `#fbbf24` | Status "Chờ cân" | Vàng cảnh báo (pulse) |
| **Danger Red** | `#ef4444` | Status "Lỗi", nguy hiểm | Đỏ lỗi |
| **Info Blue** | `#3b82f6` | Thông tin phụ | Xanh thông tin |
| **Gray Light** | `#f3f4f6` | Background | Xám nhạt |
| **Gray** | `#d1d5db` | Border, divider | Xám trung bình |
| **Gray Dark** | `#6b7280` | Text phụ | Xám đậm |
| **Text Dark** | `#1f2937` | Text chính | Đen |
| **Text Light** | `#6b7280` | Text phụ | Xám nhạt |

---

## 📐 Quy Chuẩn Kỹ Thuật

### Tỷ Lệ Màn Hình
- **Chiều rộng:** 375px (Standard Android/iOS mobile)
- **Chiều cao:** 100vh (Full viewport height)
- **Safe Area:** 12px padding từ các cạnh
- **Bottom nav height:** 60px

### Kích Thước Chữ
| Mục đích | Font Size | Weight | Ứng dụng |
|---------|-----------|--------|---------|
| Header chính | 1.4em | 700 | Tiêu đề màn hình |
| Tiêu đề phần | 0.9em | 700 | Section title |
| Giá trị lớn | 2em | 700 | Stat value, số liệu |
| Text chính | 0.95em | 400-600 | Nội dung thường |
| Text nhỏ | 0.8em | 500-600 | Helper text, label |
| Badge/Label | 0.75em | 700 | Trạng thái |

### Khoảng Cách (Spacing)
- **Padding phần tử:** 12-14px
- **Margin section:** 16px top, 10px bottom
- **Gap list:** 10px
- **Border radius:** 8-12px

### Bóng & Độ sâu (Shadows)
```css
/* Light shadow - list items */
box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);

/* Medium shadow - hover state */
box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);

/* Deep shadow - active state */
box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
```

### Transitions & Animations
```css
/* Standard transition */
transition: all 0.3s ease;

/* Button press animation */
transform: scale(0.97);

/* Fade in screen */
animation: slideIn 0.3s ease-out;

/* Pulse animation (warning status) */
animation: pulse 2s ease-in-out infinite;
```

---

## 🖼️ Kích Thước Yếu Tố UI

### Nút Bấm (Button)
- **Min Height:** 48px (accessibility standard)
- **Padding:** 14px horizontal, 14px vertical
- **Border Radius:** 8px
- **Font Size:** 0.95em, Weight 600
- **Text Transform:** UPPERCASE

### Input Fields / Select
- **Min Height:** 44px (mobile touch target)
- **Padding:** 12px
- **Border:** 2px solid
- **Border Radius:** 8px
- **Font Size:** 1em (tránh zoom trên iOS)

### Thẻ (Card)
- **Border Left:** 5px (status indicator)
- **Padding:** 14px
- **Border Radius:** 12px
- **Min Height:** 80px (order card)
- **Shadow:** Light (0 2px 6px)

### Status Badge
- **Padding:** 8px 12px
- **Border Radius:** 6px
- **Font Size:** 0.75em
- **Font Weight:** 700
- **Text Transform:** UPPERCASE

---

## 📱 12 Màn Hình Chính

### 1️⃣ **Đăng Nhập (Login)**
- ⚖️ Logo
- Ô nhập tài khoản
- Ô nhập mật khẩu
- Nút ĐĂNG NHẬP

**Thành phần:**
- Logo icon: 3em
- Form bãn: 2
- Button: 1 primary

---

### 2️⃣ **Trang Chủ (Dashboard)**
**Hiển thị ngay khi mở app**

**Bố cục:**
1. Header: TRANG CHỦ + Hôm nay
2. Stats row 1: Sản lượng hôm nay | Số xe hôm nay
3. Stats row 2: Sản lượng tháng | Lệnh chờ cân
4. Biểu đồ 7 ngày
5. Lệnh khẩn cấp (2-3 thẻ)

**Mục đích:** Ban giám đốc / Quản lý xem ngay số liệu tổng quan

---

### 3️⃣ **Danh Sách Lệnh (Orders List)**
**Quản lý tất cả lệnh giao hàng**

**Thành phần:**
- Nút "+ TẠO LỆNH MỚI"
- Danh sách lệnh (scroll)
- Mỗi lệnh hiển thị:
  - Mã lệnh (LH-20260428-001)
  - Khách hàng
  - Biển số xe
  - Loại hàng
  - **Status badge** (Chờ/Cân vào/Hoàn tất/Lỗi)

**Status Badge Colors:**
| Status | Màu | Code |
|--------|-----|------|
| CHỜ CÂN | 🟡 Yellow | `badge-wait` |
| CÂN VÀO | 🔵 Blue | `badge-weighed-in` |
| CÂN RA | 🟣 Purple | `badge-weighed-out` |
| HOÀN TẤT | 🟢 Green | `badge-completed` |
| LỖI | 🔴 Red | `badge-abnormal` |

---

### 4️⃣ **Tạo Lệnh (Create Order)**
**Form nhập thông tin giao hàng**

**Các trường:**
- Select: Khách hàng
- Select: Địa bàn
- Input: Cửa hàng
- Input: Biển số xe (format: **AA-12345**)
- Input: Lái xe
- Select: Loại sản phẩm (PCB30, PCB40, Xi Măng Tiên Sơn)
- Input: Số lượng dự kiến (Tấn)
- Textarea: Ghi chú

**Nút:**
- LƯU LỆNH (Primary)
- QUAY LẠI (Secondary)

---

### 5️⃣ **Cân Xe Vào (Weigh In)**
**Nhân viên phòng cân nhập trọng lượng xe khi vào**

**Info Box:**
- 📋 Lệnh hiện tại: LH-20260428-001

**Chi tiết lệnh (Calc Box):**
- Khách hàng: Công ty A
- Biển số: 29A-12345
- Loại hàng: Xi Măng Portland
- Dự kiến: 30 Tấn

**Input cân vào:**
- ⚖️ Trọng lượng (kg) *[Required]*
- 🕐 Giờ cân vào *[Required]*

**Nút:** ✓ XÁC NHẬN CÂN VÀO (Primary)

---

### 6️⃣ **Cân Xe Ra (Weigh Out)**
**Nhân viên cân lại trọng lượng xe ra & hệ thống tự tính khối lượng**

**Info Box:**
- 📋 Lệnh hiện tại: LH-20260428-002

**Hiển thị:**
- Calc Box: Trọng lượng vào

**Input:**
- ⚖️ Trọng lượng cân ra (kg)
- 🕐 Giờ cân ra

**Tự động tính toán:**
```
Khối lượng hàng = Trọng lượng ra - Trọng lượng vào
Ví dụ: 50.25T - 8.45T = 41.8T
```

**Nút:** ✓ HOÀN THÀNH & LƯU (Primary)

---

### 7️⃣ **Phiếu Cân (Receipt)**
**Xem chi tiết phiếu sau khi hoàn tất**

**Info Box:**
- 📄 Số phiếu: PC-20260428-0001

**Chi tiết phiếu (Calc Box):**
- Ngày giờ: 28/04 - 10:15
- Khách hàng: Công ty A
- Biển số xe: 29A-12345
- Loại hàng: Xi Măng Portland
- Cân vào: 8,450 kg
- Cân ra: 50,250 kg
- **Khối lượng thực: 41.8 Tấn** (bold, larger)

**Nút:**
- 🖨 IN PHIẾU
- 📄 XUẤT PDF

---

### 8️⃣ **Báo Cáo Kinh Doanh (Business Report)**
**Dành cho phòng kinh doanh - phân tích sản lượng theo nhiều chiều**

**Bộ lọc:**
- Chọn ngày (Date picker)
- Select: Tháng này / Tháng trước / Năm nay

**Sản lượng theo ngày:**
- Ngày 28/04: 245 Tấn
- Ngày 27/04: 210 Tấn
- Ngày 26/04: 320 Tấn

**Top khách hàng:**
- 1. Công ty A: 850 Tấn
- 2. Công ty B: 720 Tấn
- 3. Công ty C: 650 Tấn

---

### 9️⃣ **Báo Cáo Ban Giám Đốc (CEO Report)**
**Dashboard cho lãnh đạo - tổng hợp và cảnh báo**

**Stats 2x2:**
- Hôm nay: 245 Tấn
- Tháng này: 1,240 Tấn
- Năm nay: 45K Tấn
- Số xe hôm nay: 12 chiếc

**Biểu đồ:** Xu hướng tháng này (7 ngày)

**Top khách hàng (2):**
- 1. Xi Măng Hòa Phát: 1,200 Tấn
- 2. Công ty A: 950 Tấn

**Cảnh báo:**
- ❌ 1 phiếu có sai sót cần kiểm tra (Red alert box)

---

### 🔟 **Quản Lý Khách Hàng (Customers)**
**Danh sách khách hàng, thêm/sửa**

**Nút:** + THÊM KHÁCH HÀNG

**Danh sách:**
- Xi Măng Hòa Phát | 📍 Hà Nội | 📞 0912-345-678
- Công ty A | 📍 Hải Phòng | 📞 0913-456-789
- Công ty B | 📍 Hải Dương | 📞 0914-567-890

---

### 1️⃣1️⃣ **Quản Lý Xe (Vehicles)**
**Danh sách biển số xe và lái xe**

**Nút:** + THÊM XE MỚI

**Danh sách:**
- 29A-12345 | 👤 Nguyễn Văn A | 📞 0912-345-678 | 🏢 Công ty Vận Tải 1
- 51B-54321 | 👤 Trần Văn B | 📞 0913-456-789 | 🏢 Công ty Vận Tải 2

---

### 1️⃣2️⃣ **Cài Đặt (Settings)**
**Thông tin tài khoản & cấu hình**

**Thông tin tài khoản:**
- Tên nhân viên: Admin
- Vai trò: Quản trị viên
- Phòng ban: Phòng cân

**Bảo mật:**
- Nút: THAY ĐỔI MẬT KHẨU

**Thông tin ứng dụng:**
- Phiên bản: v2.0.0
- Trạng thái: ✓ Mới nhất (green)

**Nút đăng xuất:** ĐĂNG XUẤT (Danger red)

---

## 🧭 Luồng Thao Tác Chính

### Nhân viên phòng cân:
1. Đăng nhập
2. Xem trang chủ
3. Vào Danh sách lệnh
4. Bấm lệnh → Cân xe vào
5. Nhập trọng lượng + giờ → Xác nhận
6. Tiếp theo bấm lệnh có status "Cân vào" → Cân xe ra
7. Hệ thống tự tính → Hoàn thành & lưu
8. Xem phiếu / In phiếu

### Quản lý/Giám đốc:
1. Đăng nhập
2. Xem Trang chủ (dashboard) → Thống kê nhanh
3. Vào Báo cáo CEO → Thống kê tổng hợp + cảnh báo
4. Xem Báo cáo kinh doanh → Phân tích các khách hàng

---

## 🎮 Tương Tác & Feedback

### Button Interactions
- **Hover (desktop):** Màu nhạt hơn 10%, shadow tăng
- **Press/Active:** Scale 0.97, shadow tăng, color đậm hơn
- **Disabled:** Opacity 0.5

### Status Badges
- **CHỜ CÂN:** Áp dụng animation pulse (blinks)
- **CÂN VÀO:** Static, highlight xanh dương
- **HOÀN TẤT:** Static, highlight xanh lá
- **LỖI:** Static, highlight đỏ

### Cards & Lists
- Smooth shadow elevation on press
- Slight translate up animation (-2px)
- Bottom nav icons scale up on active (1.15x)

---

## 📏 Font Stack

**Tất cả.**
```css
-apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', sans-serif
```

- **Font chính:** System font (tích hợp sẵn trên iOS/Android)
- **Lợi ích:** Nhanh, không cần tải font, responsive, clean

---

## 🔒 Quy Chuẩn Accessibility

- **Min touch target:** 48x48px (buttons, nav items)
- **Min input height:** 44px
- **Color contrast:** WCAG AA standard
- **Focus states:** Visible border + shadow
- **Text scaling:** Readable at zoom level 200%

---

## 📦 Công Nghệ & Công Cụ

**File thiết kế hiện tại:**
- `app-v2.html` - HTML + CSS responsive (mobile-first)

**Chuyển sang lập trình:**
- **Frontend:** React Native / Flutter / Swift (iOS) / Kotlin (Android)
- **Backend:** Node.js / Python / PHP
- **Database:** PostgreSQL / MySQL / MongoDB
- **API:** REST API

**Triển khai:**
- **iOS:** App Store Connect
- **Android:** Google Play Console
- **Web version (optional):** Progressive Web App (PWA)

---

## ✨ Một Số Điểm Nổi Bật

✅ **Font chữ rõ ràng** - System font sizes từ 0.75em-2em  
✅ **Nút bấm lớn** - Min 48px per accessibility standard  
✅ **Trạng thái rõ ràng** - 5 màu status khác nhau  
✅ **Bottom navigation** - 5 tab nhanh chóng  
✅ **Mô tả trực quan** - Icon emoji + text  
✅ **Tự động tính toán** - Cân vào/ra tự compute khối lượng  
✅ **Báo cáo nhanh** - 3 loại báo cáo khác nhau  
✅ **Responsive** - Các device Android / iOS 375px+  
✅ **Dark/Light mode ready** - CSS variables sẵn  

---

## 📞 Hỗ Trợ & Liên Hệ

Để cải thiện thêm hoặc có câu hỏi về thiết kế:
- Kiểm tra lại file `app-v2.html`
- Test trên browser độ phân giải 375px
- Feedback chi tiết về UX/UI

---

**Version:** v2.0.0  
**Last Updated:** 28/04/2026  
**Status:** ✅ Ready for Development
