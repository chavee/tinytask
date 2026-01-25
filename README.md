# StarterWeb Task Board

Welcome to the StarterWeb Task Board, a minimal web application designed for learning the fundamentals of Continuous Integration (CI) with GitHub Actions. This project is intentionally simple to keep the focus on the DevOps concepts.

*(English version below)*

---

### 🇹🇭 ภาษาไทย

ยินดีต้อนรับสู่ StarterWeb Task Board โปรเจกต์เว็บแอปพลิเคชันขนาดเล็กที่ออกแบบมาเพื่อการเรียนรู้พื้นฐานของ Continuous Integration (CI) ด้วย GitHub Actions โดยเฉพาะ โปรเจกต์นี้ถูกสร้างให้เรียบง่ายที่สุดเพื่อมุ่งเน้นที่คอนเซ็ปต์ของ DevOps

#### การรันโปรเจกต์บนเครื่อง (Local)

1.  **Prerequisites**: ต้องมี [Node.js](https://nodejs.org/) (เวอร์ชัน 20) และ [Docker](https://www.docker.com/products/docker-desktop/) ติดตั้งบนเครื่อง
2.  **Clone a repository**:
    ```bash
    git clone https://github.com/{your-username}/starterweb-taskboard.git
    cd starterweb-taskboard
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

#### CI Pipeline Stages (ขั้นตอนใน CI)

ไฟล์ `.github/workflows/ci.yml` ของเราประกอบด้วยขั้นตอนหลักๆ ดังนี้:

1.  **Lint**: `npm run lint` - ตรวจสอบคุณภาพของโค้dด้วย ESLint เพื่อให้แน่ใจว่าโค้ดเป็นไปตามสไตล์ที่กำหนด
2.  **Test**: `npm test` - รันชุดการทดสอบด้วย Jest เพื่อตรวจสอบว่าฟังก์ชันต่างๆ ของแอปพลิเคชันทำงานถูกต้อง (Lab แรกจะเริ่มที่ขั้นตอนนี้ فاش)
3.  **Build**: `npm run build` - แปลงโค้ด TypeScript (ในโฟลเดอร์ `src`) ไปเป็น JavaScript (ในโฟลเดอร์ `dist`) ที่พร้อมใช้งานจริง
4.  **Cache**: `setup-node` action มี `cache: 'npm'` ซึ่งจะเก็บ `node_modules` ที่ดาวน์โหลดไว้ ทำให้การรันครั้งต่อไปเร็วขึ้นมาก
5.  **Artifact**: `upload-artifact` - หลังจาก Build สำเร็จ โฟลเดอร์ `dist` จะถูกเก็บไว้เป็น "Artifact" ของ CI run นั้นๆ เราสามารถดาวน์โหลดมาตรวจสอบหรือนำไปใช้งานต่อได้
6.  **Docker Smoke Test**: สร้าง Docker image จาก `Dockerfile` แล้วลองรัน container ขึ้นมา จากนั้นใช้ `curl` ยิงไปที่ `/health` endpoint เพื่อ "ทดสอบควัน" ว่าเซิร์ฟเวอร์ใน container สตาร์ทขึ้นมาและตอบสนองได้จริงๆ

---

### Lab Activities: ภารกิจ CI/CD

#### ☐ Lab 1: ทำให้ CI กลับมาเป็นสีเขียว (Fix the Failing CI)

**เป้าหมาย:** CI pipeline ของเราตอนนี้มีสถานะ "failing" (สีแดง) เพราะมีเทสหนึ่งตัวที่ไม่ผ่าน จงแก้ไขโค้ดเพื่อให้เทสทั้งหมดผ่านและ CI กลับมาเป็นสีเขียว

1.  ไปที่แท็บ "Actions" ใน GitHub repository ของคุณ
2.  คลิกที่ Workflow runล่าสุดที่กำลังเฟล (สีแดง)
3.  ดูใน Job `build-and-test` แล้วหาขั้นตอน `Run tests` ที่เฟล
4.  อ่าน Log เพื่อดูว่าเทสไหนที่ไม่ผ่าน และเฟลเพราะอะไร
    - **Hint**: เทสคาดหวังว่าการสร้าง task ด้วยชื่อที่เป็น "ช่องว่าง" (whitespace) อย่างเดียวควรจะถูกปฏิเสธ (HTTP 400) แต่เซิร์ฟเวอร์กลับยอมรับ (HTTP 201)
5.  แก้ไขโค้ดในไฟล์ `src/taskStore.ts` เพื่อให้ validation ของ `addTask` ทำงานได้ถูกต้อง
6.  `git commit` และ `git push` โค้ดที่แก้ไขแล้วกลับขึ้นไป
7.  กลับไปดูที่แท็บ Actions อีกครั้ง และยืนยันว่า CI run ใหม่ของคุณผ่าน (สีเขียว)

#### ☐ Lab 2: ทำความเข้าใจเรื่อง Cache

**เป้าหมาย:** สังเกตการทำงานของ Cache ใน GitHub Actions

1.  ใน CI run ครั้งแรกของคุณ (ที่เฟล) ให้ดูที่ขั้นตอน `Install dependencies` จะเห็นว่าใช้เวลาสักครู่ในการดาวน์โหลด
2.  เมื่อคุณ Push โค้ดที่แก้แล้วใน Lab 1 ให้ดู CI run ครั้งที่สอง
3.  สังเกตที่ขั้นตอน `Install dependencies` อีกครั้ง คุณจะเห็นข้อความประมาณ `Cache hit` หรือ `Loading from cache` และขั้นตอนนี้จะใช้เวลาเกือบจะทันที
4.  นี่คือผลของ `cache: 'npm'` ที่ช่วยเร่งความเร็ว CI ของเรา

#### ☐ Lab 3: การดาวน์โหลดและตรวจสอบ Artifact

**เป้าหมาย:** เรียนรู้วิธีดาวน์โหลด Build Artifact จาก GitHub Actions

1.  ไปที่ CI run ที่สำเร็จแล้ว (สีเขียว)
2.  ในหน้า "Summary" ของ run นั้นๆ ให้มองหา section ที่ชื่อว่า "Artifacts"
3.  คุณจะเห็นไฟล์ชื่อ `dist` (ซึ่งเป็นผลลัพธ์จากขั้นตอน `upload-artifact`)
4.  คลิกเพื่อดาวน์โหลดไฟล์ zip นั้นมา
5.  แตกไฟล์ zip ออกมาดู คุณจะพบโฟลเดอร์ `dist` ที่มีไฟล์ `.js` ที่ผ่านการ build แล้ว นี่คือโค้ดที่เราจะนำไป deploy จริง

#### ☐ Lab 4: ทำความเข้าใจ Docker Smoke Test

**เป้าหมาย:** เข้าใจว่าทำไมเราต้องมี Job `docker-smoke-test`

1.  ดูที่ `ci.yml` ใน Job `docker-smoke-test`
2.  ขั้นตอนนี้จะทำงาน *หลังจาก* `build-and-test` ผ่านแล้วเท่านั้น
3.  มันจำลองการใช้งานจริง: คือการ build Docker image และลองรันมันขึ้นมา
4.  ขั้นตอน "Smoke test with curl" คือการตรวจสอบที่สำคัญที่สุด มันเป็นการยืนยันว่า:
    - Docker image ของเรา build ได้สำเร็จ
    - Container สามารถรันจาก image นั้นได้โดยไม่แครช
    - แอปพลิเคชันข้างใน container เริ่มทำงานและพร้อมให้บริการที่ port 3000
5.  ถ้าขั้นตอนทั้งหมดนี้ผ่าน เราจะมีความมั่นใจสูงว่า Docker image ของเราพร้อมสำหรับนำไป deploy บนเซิร์ฟเวอร์จริง

---

### 🇬🇧 English

Welcome to the StarterWeb Task Board, a minimal web application designed for learning the fundamentals of Continuous Integration (CI) with GitHub Actions. This project is intentionally simple to keep the focus on the DevOps concepts.

#### Running Locally

1.  **Prerequisites**: You must have [Node.js](https://nodejs.org/) (version 20) and [Docker](https://www.docker.com/products/docker-desktop/) installed.
2.  **Clone a repository**:
    ```bash
    git clone https://github.com/{your-username}/starterweb-taskboard.git
    cd starterweb-taskboard
    ```
3.  **Set up environment**:
    ```bash
    cp .env.example .env
    ```
4.  **Install dependencies**:
    ```bash
    npm install
    ```
5.  **Run in development mode**: (The server will auto-restart on code changes)
    ```bash
    npm run dev
    ```
6.  Open your browser to `http://localhost:3000`.

#### CI Pipeline Stages

Our `.github/workflows/ci.yml` file consists of the following key stages:

1.  **Lint**: `npm run lint` - Checks code quality with ESLint to ensure a consistent coding style.
2.  **Test**: `npm test` - Runs the test suite with Jest to verify that the application's functions are working correctly. (Your first lab starts with this failing step!)
3.  **Build**: `npm run build` - Compiles the TypeScript code (from `src/`) into production-ready JavaScript (in `dist/`).
4.  **Cache**: The `setup-node` action includes `cache: 'npm'`, which stores the downloaded `node_modules`. This makes subsequent runs much faster.
5.  **Artifact**: `upload-artifact` - After a successful build, the `dist/` folder is saved as an "Artifact" for that CI run. We can download it to inspect or deploy.
6.  **Docker Smoke Test**: Builds a Docker image from the `Dockerfile`, runs a container, and then uses `curl` to hit the `/health` endpoint for a "smoke test" to confirm the server inside the container started and is responsive.

---

### Lab Activities: CI/CD Missions

#### ☐ Lab 1: Fix the Failing CI

**Goal:** Our CI pipeline is currently failing. Your mission is to fix the code to make all tests pass and get a green "passing" build.

1.  Navigate to the "Actions" tab in your GitHub repository.
2.  Click on the latest failing workflow run (it will be red).
3.  In the `build-and-test` job, find the failing `Run tests` step.
4.  Read the log to see which test failed and why.
    - **Hint**: The test expects that creating a task with a whitespace-only title (e.g., `"   "`) should be rejected (HTTP 400), but the server is currently accepting it (HTTP 201).
5.  Fix the code in `src/taskStore.ts` to correctly validate the input in the `addTask` function.
6.  `git commit` and `git push` your fix.
7.  Return to the "Actions" tab and confirm that your new CI run completes successfully (green).

#### ☐ Lab 2: Understanding the Cache

**Goal:** Observe how caching works in GitHub Actions.

1.  In your first (failed) CI run, look at the `Install dependencies` step. Note how long it took.
2.  After you push the fix from Lab 1, look at your second CI run.
3.  Observe the `Install dependencies` step again. You should see a message like `Cache hit` or `Loading from cache`, and the step will complete almost instantly.
4.  This is the effect of `cache: 'npm'`, which speeds up our pipeline.

#### ☐ Lab 3: Downloading and Inspecting an Artifact

**Goal:** Learn how to download a build artifact from GitHub Actions.

1.  Navigate to a successful (green) workflow run.
2.  On the "Summary" page for that run, look for the "Artifacts" section.
3.  You will see an artifact named `dist` (the output from our `upload-artifact` step).
4.  Click to download the zip file.
5.  Unzip it, and you will find the `dist` folder containing the compiled `.js` files. This is the code we would deploy to production.

#### ☐ Lab 4: Understanding the Docker Smoke Test

**Goal:** Understand why the `docker-smoke-test` job is important.

1.  Look at the `docker-smoke-test` job in `ci.yml`.
2.  This job only runs *after* the `build-and-test` job succeeds.
3.  It simulates a real-world scenario: building the Docker image and trying to run it.
4.  The "Smoke test with curl" step is the crucial validation. It confirms that:
    - Our Docker image builds successfully.
    - A container can run from that image without crashing.
    - The application inside the container starts up correctly and serves traffic on port 3000.
5.  If this job passes, we have high confidence that our Docker image is ready for deployment.
