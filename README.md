# TinyTask Board

ยินดีต้อนรับสู่ TinyTask Board โปรเจกต์เว็บแอปพลิเคชันขนาดเล็กที่ออกแบบมาเพื่อการเรียนรู้พื้นฐานของ Continuous Integration (CI) ด้วย GitHub Actions โดยเฉพาะ โปรเจกต์นี้ถูกสร้างให้เรียบง่ายที่สุดเพื่อมุ่งเน้นที่คอนเซ็ปต์ของ DevOps

#### การรันโปรเจกต์บนเครื่อง (Local)

1.  **Prerequisites**: ต้องมี [Node.js](https://nodejs.org/) (เวอร์ชัน 20) และ [Docker](https://www.docker.com/products/docker-desktop/) ติดตั้งบนเครื่อง
2.  **Clone a repository**:
    ```bash
    git clone https://github.com/{your-username}/tinytask.git
    cd tinytask
    ```
3.  **Set up environment**:
    ```bash
    cp .env.example .env
    ```
4.  **Install dependencies**:
    ```bash
    npm install
    ```
5.  **Run in development mode**: (เซิร์ฟเวอร์จะรีสตาร์ทอัตโนมัติเมื่อมีการแก้โค้ด)
    ```bash
    npm run dev
    ```
6.  เปิดเบราว์เซอร์ไปที่ `http://localhost:3000`
