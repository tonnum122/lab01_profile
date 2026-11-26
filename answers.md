# Lab L1 · answers.md (TH)

- ชื่อ-สกุล นายกฤตชานนท์ ณ ปานแก้ว
- รหัสนักศึกษา 67116046
- ลิงก์ repo [tonnum122/lab01_profile](https://github.com/tonnum122/lab01_profile)

## Q1 · เครื่องมือ

รอบแรก `flutter doctor` ตรวจ Flutter ผ่าน แต่ Android toolchain ขึ้น `Unable to locate Android SDK.` จึงติดตั้ง Android SDK Platform 36, Build-Tools, Command-line Tools และ Platform-Tools พร้อมใช้ JDK 17 และตั้ง `ANDROID_HOME` ให้ชี้ไปที่ SDK ที่ติดตั้ง จากนั้นใช้ Android SDK Manager เพื่อยอมรับเงื่อนไขของ SDK แล้วรัน `flutter doctor` ซ้ำ ผลคือ Flutter 3.50.0 และ Android toolchain ที่ใช้ SDK 36.0.0 ผ่านทั้งคู่ [คู่มือตั้งค่า Android ของ Flutter](https://docs.flutter.dev/platform-integration/android/setup)

## Q2 · Reload

ตอนทดสอบบน Android emulator กด Like จนได้ 3 แล้วแก้ AppBar เป็น `Lab L1 done · 67116046` ชั่วคราว พอกด `r` ข้อความบน AppBar เปลี่ยนและยังเห็น `Likes: 3` เพราะ Flutter สร้างหน้าจอจากโค้ดใหม่โดยเก็บ `State` เดิมไว้ พอกด `R` แอปเริ่มจาก `main()` อีกครั้งและสร้าง `State` ใหม่ จึงเห็น `Likes: 0` ตามค่าเริ่มต้นของ `_likes` หลังทดลองเสร็จคืนข้อความ AppBar ตามเดิม

## Q3 · โค้ดและ Git

`_likes++` เพิ่มค่าที่เก็บใน `_HomePageState` ส่วน `setState` แจ้ง Flutter ให้เรียก `build()` ในเฟรมถัดไป ข้อความ `Likes` จึงแสดงตัวเลขใหม่หลังการกดปุ่ม Commit `Add like counter with setState` เปลี่ยน `HomePage` เป็น `StatefulWidget` แล้วเพิ่ม `_likes`, ปุ่ม Like และข้อความที่อ่านค่าจากตัวนับ

## ตารางทดสอบ

| ประเภท | input หรือการกระทำ | ผลที่คาดหวัง | ผลจริง |
|---|---|---|---|
| Normal | เปิดแอป | AppBar มีรหัส มีไอคอน ชื่อ และ `Likes: 0` | เปิดบน Android emulator แล้วเห็นครบ และตัวนับเริ่มที่ `Likes: 0` |
| Normal | กด Like หนึ่งครั้ง | `Likes: 1` | Android emulator แสดง `Likes: 1` ทันทีหลังแตะ |
| Boundary | กด Like เร็ว ๆ 20 ครั้งจาก 0 | `Likes: 20` และไม่มี error | Android emulator รับการแตะครบ 20 ครั้งและแสดง `Likes: 20` แอปยังทำงานต่อได้ |
| Boundary | หมุนจอเป็นแนวนอน | เนื้อหาอยู่กลางจอและไม่มี overflow | บนจอแนวนอน 1920 × 1080 เห็นไอคอน ชื่อ ตัวนับ และปุ่มครบตรงกลางพื้นที่แอป โดยยังเป็น `Likes: 20` |
| Reload | กด Like 3 ครั้งจาก 0 แก้ AppBar แล้วกด `r` ตามด้วย `R` | หลัง `r` คงค่า 3 หลัง `R` กลับเป็น 0 | หลัง `r` เห็น AppBar ที่แก้แล้วและ `Likes: 3` หลัง `R` เห็น `Likes: 0` บน Android emulator |
| Failure | ปิด emulator แล้วรัน `flutter run -d emulator-5554 --no-pub` | Flutter แจ้งว่าไม่พบอุปกรณ์ที่เลือก | หลังปิด emulator ได้ข้อความ `No supported devices found with name or id matching 'emulator-5554'.` |

Widget test จาก starter ผ่านทั้ง 6 กรณีด้วย ผลในตารางมาจากการลองกับ Android emulator และ Flutter CLI จริง

## การใช้ AI

ใช้ Codex ช่วยตรวจสถานะโปรเจกต์ เขียนแอป เตรียม Android SDK รันชุดทดสอบ ทดลอง hot reload และ hot restart และเรียบเรียงผลทดสอบจากสิ่งที่ตรวจได้จริง
