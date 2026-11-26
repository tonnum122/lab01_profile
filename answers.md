# Lab L1 · answers.md (TH)

- ชื่อ-สกุล นายกฤตชานนท์ ณ ปานแก้ว
- รหัสนักศึกษา 67116046
- ลิงก์ repo [tonnum122/lab01_profile](https://github.com/tonnum122/lab01_profile)

## Q1 · เครื่องมือ

รอบแรก `flutter doctor` ตรวจ Flutter ผ่าน แต่ Android toolchain ขึ้น `Unable to locate Android SDK.` จึงติดตั้ง Android SDK Platform 36, Build-Tools, Command-line Tools และ Platform-Tools พร้อมตั้ง `ANDROID_HOME` ให้ชี้ไปที่ SDK ที่ติดตั้ง รอบถัดไป Flutter เห็น SDK 36.0.0 แล้ว สถานะ Android toolchain ยังรอการยอมรับเงื่อนไข SDK [คู่มือตั้งค่า Android ของ Flutter](https://docs.flutter.dev/platform-integration/android/setup)

## Q2 · Reload

ทดสอบกับแอปที่รันใน Chrome debug โดยเรียกปุ่ม Like ให้ได้ 3 แล้วแก้ AppBar เป็น `Lab L1 done · 67116046` ชั่วคราว กด `r` แล้วข้อความใน AppBar เปลี่ยน แต่ Likes ยังเป็น 3 เพราะ Flutter เรียก `build()` โดยใช้ `State` เดิม พอกด `R` แอปเรียก `main()` ใหม่และสร้าง `State` ใหม่ ค่า `_likes` จึงกลับเป็น 0 ในรอบนี้ตัวเรนเดอร์ของ Chrome debug แสดงข้อความ `Trying to render a disposed EngineFlutterView` ระหว่าง restart จากนั้นแอปเริ่มใหม่และตรวจค่า 0 ได้

## Q3 · โค้ดและ Git

`_likes++` เพิ่มค่าที่เก็บใน `_HomePageState` ส่วน `setState` แจ้ง Flutter ให้เรียก `build()` ในเฟรมถัดไป ข้อความ `Likes` จึงแสดงตัวเลขใหม่หลังการกดปุ่ม Commit `Add like counter with setState` เปลี่ยน `HomePage` เป็น `StatefulWidget` แล้วเพิ่ม `_likes`, ปุ่ม Like และข้อความที่อ่านค่าจากตัวนับ

## ตารางทดสอบ

| ประเภท | input หรือการกระทำ | ผลที่คาดหวัง | ผลจริง |
|---|---|---|---|
| Normal | เปิดแอป | AppBar มีรหัส มีไอคอน ชื่อ และ `Likes: 0` | ได้ตามคาดใน widget test และตรวจชื่อ รหัส และ `Likes: 0` จาก widget tree ของ Chrome debug |
| Normal | กด Like หนึ่งครั้ง | `Likes: 1` | ได้ `Likes: 1` ใน widget test และ Chrome debug |
| Boundary | กด Like เร็ว ๆ 20 ครั้งจาก 0 | `Likes: 20` และไม่มี error | widget test กด 20 ครั้งติดกันแล้วได้ `Likes: 20` และไม่มี exception |
| Boundary | หมุนจอเป็นแนวนอน | เนื้อหาอยู่กลางจอและไม่มี overflow | widget test ขนาด 800 × 360 ผ่าน เนื้อหาอยู่กึ่งกลางแนวนอนและไม่มี overflow |
| Reload | กด Like 3 ครั้งจาก 0 แก้ AppBar แล้วกด `r` ตามด้วย `R` | หลัง `r` คงค่า 3 หลัง `R` กลับเป็น 0 | ทดสอบคำสั่งจริงใน Chrome debug หลัง `r` ได้ `Likes: 3` พร้อม AppBar ใหม่ หลัง `R` ได้ `Likes: 0` |
| Failure | ปิด emulator แล้วรัน `flutter run -d <emulator-id>` | Flutter แจ้งว่าไม่พบอุปกรณ์ที่เลือก | รอทดสอบหลังตั้งค่า Android emulator เสร็จ |

## การใช้ AI

ใช้ Codex ช่วยตรวจสถานะโปรเจกต์ เขียนแอป เตรียม Android SDK รันชุดทดสอบ ทดลอง hot reload และ hot restart และเรียบเรียงผลทดสอบจากสิ่งที่ตรวจได้จริง
