## วิธีติดตั้งแอพจากไฟล์ .apk
1. เข้าเมนู การตั้งค่า > ความปลอดภัย แล้วกดเปิด ไม่รู้จักที่มา
2. ดาวน์โหลดไฟล์ apk มาลงเครื่อง แล้วกดเปิดไฟล์ได้จากแถบแจ้งเตือน หรือในแอพ File Manager
3. กด ติดตั้ง แล้วกดเปิดใช้งานแอพได้เลย
**หากเปิดใช้งานไม่ได้ ก็เป็นไปได้ว่าเครื่องของคุณใช้แอพไม่ได้


## วิธีออกแบบโปรแกรมและ algorithm
ตัวเกมจะมี UI 3 หน้าดังนี้ หน้าหลัก,หน้าเล่นเกมและหน้าประวัติการเล่น  จะออกแบบให้เป็นแนวเกมสมัยเก่า ฟ้อนจะใช้เป็น pressStart2P และสีของพื้นหลังจะเป็นเขียวอ่อน เป็น widget อื่นๆ จะเล่นสีสว่าง
1. หน้าหลัก จะมี TextField ให้กรอกเพื่อกำหนดขนาดของตาราง XO จะมีขนาดตั้งแต่ 3x3,4x4,5x5,6x6,7x7และ8x8 และ floatingActionButton วงกลมสีเขียวจะเป็นการเริ่มเกม
2. หน้าเล่นเกม จะมีการเก็ยคะแนนทั้ง2ผู้เล่นคือ player o และ player x ถัดมาจะ GridView ขนาดต่างๆตามที่รับค่ามา pattern การเล่นผู้เล่นจะกรอกข้อมูล X || O สลับกันไป และหาผู้ชนะจากกติกา xo ทั่วไป เมื่อชนะหรือเสมอจะมี Dialog แจ้งเตือน และปุ่มด้านล่างเป็นการดูประวัติการเล่น
**ตัวอย่าง ขนาด 3x3 ถ้าผู้เล่นวางข้อมูลเรียงติดกัน 3ตัวก่อน เป็นแนวนอน แนวตั้งหรือแนวทะแยงจะถือว่าชนะ และขนาดอื่นๆ จะวางเรียงติดกัน 4,5,6,7,8 ตามลำดับ 
3. หน้าประวัติการเล่น จะเป็น ListTitle จะบอก MATCH ที่เล่นและผู้ชนะ และปุ่มด้านล่างเป็นการลบประวัติการเล่นทั้งหมด

**algorithm**
ในตาราง GridView จะมีการใส่ Listข้อมูลชนิด String และจะเช็คผู้ชนะจากการนับ index 
0 | 1 | 2
3 | 4 | 5
6 | 7 | 8





