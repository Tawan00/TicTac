## วิธีติดตั้งแอพจากไฟล์ .apk
[Google](https://drive.google.com/file/d/1UZxMCC97sKDMjPvQwBfZBE4aCPeuPhIE/view?usp=sharing)
1. เข้าเมนู การตั้งค่า > ความปลอดภัย แล้วกดเปิด ไม่รู้จักที่มา
2. ดาวน์โหลดไฟล์ apk มาลงเครื่อง แล้วกดเปิดไฟล์ได้จากแถบแจ้งเตือน หรือในแอพ File Manager
3. กด ติดตั้ง แล้วกดเปิดใช้งานแอพได้เลย
**หากเปิดใช้งานไม่ได้ ก็เป็นไปได้ว่าเครื่องของคุณใช้แอพไม่ได้

## วิธี run โปรแกรม
1. เข้า command prompt ที่ path ของโปรแกรม
2. ใช้คำสั่ง flutter run เพื่อ setup และ run โปรแกรม


## วิธีออกแบบโปรแกรมและ algorithm
ตัวเกมจะมี UI 3 หน้าดังนี้ หน้าหลัก,หน้าเล่นเกมและหน้าประวัติการเล่น  จะออกแบบให้เป็นแนวเกมสมัยเก่า ฟ้อนจะใช้เป็น pressStart2P และสีของพื้นหลังจะเป็นเขียวอ่อน เป็น widget อื่นๆ จะเล่นสีสว่าง
1. หน้าหลัก จะมี TextField ให้กรอกเพื่อกำหนดขนาดของตาราง XO จะมีขนาดตั้งแต่ 3x3,4x4,5x5,6x6,7x7และ8x8 และ floatingActionButton วงกลมสีเขียวจะเป็นการเริ่มเกม
2. หน้าเล่นเกม จะมีการเก็ยคะแนนทั้ง2ผู้เล่นคือ player o และ player x ถัดมาจะ GridView ขนาดต่างๆตามที่รับค่ามา pattern การเล่นผู้เล่นจะกรอกข้อมูล X || O สลับกันไป และหาผู้ชนะจากกติกา xo ทั่วไป เมื่อชนะหรือเสมอจะมี Dialog แจ้งเตือน และปุ่มด้านล่างเป็นการดูประวัติการเล่น
**ตัวอย่าง ขนาด 3x3 ถ้าผู้เล่นวางข้อมูลเรียงติดกัน 3ตัวก่อน เป็นแนวนอน แนวตั้งหรือแนวทะแยงจะถือว่าชนะ และขนาดอื่นๆ จะวางเรียงติดกัน 4,5,6,7,8 ตามลำดับ 
3. หน้าประวัติการเล่น จะเป็น ListTitle จะบอก MATCH ที่เล่นและผู้ชนะ และปุ่มด้านล่างเป็นการลบประวัติการเล่นทั้งหมด

**algorithm**
Col1 | Col2 | Col3
--- |--- |--- |
0 | 1 | 2
3 | 4 | 5
6 | 7 | 8

**ยกตัวอย่าง 3*3
1. เช็คแนวนอน จะเช็คจาก index ที่ 0, 3, 6 ถ้าเริ่มจาก index 0 จะเอาช่อง 0 ไปเช็คกับช่องที่ 1 โดยการเอาค่าจากช่อง 0 + 1 (0+1) จะตกช่อง 1 และเอาช่อง 1 + 1 (1+1)จะตกช่อง 2 เซ็ตให้ช่อง 
0==1==2 ถ้าตรงตามนี้ จะเอาข้อมูลที่ช่องดังกล่าวเป็นผู้ชนะ
**บวกค่าที่ละ 1 เรื่อยๆตามขนาดของตาราง

2. เช็คแนวตั้ง จะเช็คจาก index ที่ 0, 1, 2 ถ้าเริ่มจาก index 1
จะเอาช่องที่ 1 ไปเช็คกับช่องที่ 4 โดยการเอาค่าจากช่อง + sizeของตารางคือ 3 (1+3)จะตกที่ช่อง 4 และจะเอาช่อง 4 + กับ sizeของตารางคือ 3 (4+3)จะตกที่ช่อง 7 เซ็ตให้ช่อง 
1==4==7  ถ้าตรงตามนี้ จะเอาข้อมูลที่ช่องดังกล่าวเป็นผู้ชนะ
**จะบวกSizeของตารางไปเรื่อยๆตามขนาดของตาราง

3. เช็คแนวทะแยง จะเช็คจาก index ที่ 0, 2 ถ้าเริ่มจาก index 0
จะเอาช่อง 0 ไปเช็คกับช่อง 4 โดยการเอาค่าจากช่อง 0 + sizeตาราง + 1 (0+3+1) จะตกที่ช่อง 4 และจะเอาช่อง 4 + sizeตาราง + 1 (4+3+1) จะตกที่ช่อง 8 เซ็ตให้ช่อง 0==4==8  
ถ้าตรงตามนี้ จะเอาข้อมูลที่ช่องดังกล่าวเป็นผู้ชนะ
ถ้าเริ่มจาก index 2 จะเอาช่อง 2 ไปเช็คกับช่อง 4 โดยการเอาค่าจากช่อง 2 + sizeตาราง - 1 (2+3-1) จะตกช่อง 4 และจะเอาช่อง 4 + sizeตาราง - 1 (4+3-1) จะตกช่องที่ 6 เซ็ตให้ช่อง 2==4==6  ถ้าตรงตามนี้ จะเอาข้อมูลที่ช่องดังกล่าวเป็นผู้ชนะ
**จะบวกSizeตาราง + 1 ไปเรื่อยๆตามขนาดของตาราง






