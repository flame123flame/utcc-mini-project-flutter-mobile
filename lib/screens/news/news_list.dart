import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../model_components/article.dart';
import 'news_tile.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List<Article> listNews = [
    Article(
      title:
          "เปิดแผน ‘รถเมล์ใหม่’ 7,200 คัน ‘ขสมก.-พลังงานบริสุทธิ์’ การันตี 3 ปี รถใหม่พรึ่บ",
      content:
          "แม้ปัจจุบันเมืองฟ้าอมรจะมีระบบขนส่งสาธารณะให้เลือกใช้มากมาย ทั้งรถไฟฟ้าลอยฟ้า รถไฟฟ้าใต้ดิน เรือโดยสารตามคลองต่างๆ หรือวินจักรยานยนต์ ตามจุดแยกย่อยทั่วกรุงเทพฯ แต่รถเมล์ หรือในชื่อทางการ ‘รถโดยสารประจำทาง’ ยังคงเป็นรถโดยสารสาธารณะที่มีผู้ใช้งานมากที่สุด",
      description:
          "ปัญหาหนึ่งของรถเมล์ไทยคือ มีสภาพเก่า บางคันใช้งานมามากกว่า 30 ปี รวมถึงปัญหาอื่นๆที่กลายเป็นความเคยชินไปแล้ว เช่น ปัญหาควันดำ, PM2.5 , เสียงดัง, การขับขี่ที่ไม่ปลอดภัย น่าหวาดเสียว, รอนาน , ไม่สะอาด ปัญหาการให้บริการ, เสียค่าเดินทางหลายทอด เป็นต้น ดังนั้น สิ่งที่คนกรุงเทพฯเรียกหามาโดยตลอด คือ การเปลี่ยนรถเมล์ใหม่ทั้งหมด และยกระดับการให้บริการให้ดีขึ้นกว่าที่เคยเป็น",
      urlToImage:
          "https://www.isranews.org/article/images/2022/KLE/8/Ling280865_Cover1.jpg",
      articleUrl:
          "https://www.isranews.org/article/images/2022/KLE/8/Ling280865_Cover1.jpg",
    ),
    Article(
      title:
          "เปิดแผน ‘รถเมล์ใหม่’ 7,200 คัน ‘ขสมก.-พลังงานบริสุทธิ์’ การันตี 3 ปี รถใหม่พรึ่บ",
      content:
          "แม้ปัจจุบันเมืองฟ้าอมรจะมีระบบขนส่งสาธารณะให้เลือกใช้มากมาย ทั้งรถไฟฟ้าลอยฟ้า รถไฟฟ้าใต้ดิน เรือโดยสารตามคลองต่างๆ หรือวินจักรยานยนต์ ตามจุดแยกย่อยทั่วกรุงเทพฯ แต่รถเมล์ หรือในชื่อทางการ ‘รถโดยสารประจำทาง’ ยังคงเป็นรถโดยสารสาธารณะที่มีผู้ใช้งานมากที่สุด",
      description:
          "ปัญหาหนึ่งของรถเมล์ไทยคือ มีสภาพเก่า บางคันใช้งานมามากกว่า 30 ปี รวมถึงปัญหาอื่นๆที่กลายเป็นความเคยชินไปแล้ว เช่น ปัญหาควันดำ, PM2.5 , เสียงดัง, การขับขี่ที่ไม่ปลอดภัย น่าหวาดเสียว, รอนาน , ไม่สะอาด ปัญหาการให้บริการ, เสียค่าเดินทางหลายทอด เป็นต้น ดังนั้น สิ่งที่คนกรุงเทพฯเรียกหามาโดยตลอด คือ การเปลี่ยนรถเมล์ใหม่ทั้งหมด และยกระดับการให้บริการให้ดีขึ้นกว่าที่เคยเป็น",
      urlToImage:
          "https://mpics.mgronline.com/pics/Images/565000009807501.JPEG",
      articleUrl:
          "https://mpics.mgronline.com/pics/Images/565000009807501.JPEG",
    ),
    Article(
      title:
          "เปิดแผน ‘รถเมล์ใหม่’ 7,200 คัน ‘ขสมก.-พลังงานบริสุทธิ์’ การันตี 3 ปี รถใหม่พรึ่บ",
      content:
          "แม้ปัจจุบันเมืองฟ้าอมรจะมีระบบขนส่งสาธารณะให้เลือกใช้มากมาย ทั้งรถไฟฟ้าลอยฟ้า รถไฟฟ้าใต้ดิน เรือโดยสารตามคลองต่างๆ หรือวินจักรยานยนต์ ตามจุดแยกย่อยทั่วกรุงเทพฯ แต่รถเมล์ หรือในชื่อทางการ ‘รถโดยสารประจำทาง’ ยังคงเป็นรถโดยสารสาธารณะที่มีผู้ใช้งานมากที่สุด",
      description:
          "ปัญหาหนึ่งของรถเมล์ไทยคือ มีสภาพเก่า บางคันใช้งานมามากกว่า 30 ปี รวมถึงปัญหาอื่นๆที่กลายเป็นความเคยชินไปแล้ว เช่น ปัญหาควันดำ, PM2.5 , เสียงดัง, การขับขี่ที่ไม่ปลอดภัย น่าหวาดเสียว, รอนาน , ไม่สะอาด ปัญหาการให้บริการ, เสียค่าเดินทางหลายทอด เป็นต้น ดังนั้น สิ่งที่คนกรุงเทพฯเรียกหามาโดยตลอด คือ การเปลี่ยนรถเมล์ใหม่ทั้งหมด และยกระดับการให้บริการให้ดีขึ้นกว่าที่เคยเป็น",
      urlToImage:
          "https://mpics.mgronline.com/pics/Images/565000003252401.JPEG",
      articleUrl:
          "https://mpics.mgronline.com/pics/Images/565000003252401.JPEG",
    ),
    Article(
      title:
          "เปิดแผน ‘รถเมล์ใหม่’ 7,200 คัน ‘ขสมก.-พลังงานบริสุทธิ์’ การันตี 3 ปี รถใหม่พรึ่บ",
      content:
          "แม้ปัจจุบันเมืองฟ้าอมรจะมีระบบขนส่งสาธารณะให้เลือกใช้มากมาย ทั้งรถไฟฟ้าลอยฟ้า รถไฟฟ้าใต้ดิน เรือโดยสารตามคลองต่างๆ หรือวินจักรยานยนต์ ตามจุดแยกย่อยทั่วกรุงเทพฯ แต่รถเมล์ หรือในชื่อทางการ ‘รถโดยสารประจำทาง’ ยังคงเป็นรถโดยสารสาธารณะที่มีผู้ใช้งานมากที่สุด",
      description:
          "ปัญหาหนึ่งของรถเมล์ไทยคือ มีสภาพเก่า บางคันใช้งานมามากกว่า 30 ปี รวมถึงปัญหาอื่นๆที่กลายเป็นความเคยชินไปแล้ว เช่น ปัญหาควันดำ, PM2.5 , เสียงดัง, การขับขี่ที่ไม่ปลอดภัย น่าหวาดเสียว, รอนาน , ไม่สะอาด ปัญหาการให้บริการ, เสียค่าเดินทางหลายทอด เป็นต้น ดังนั้น สิ่งที่คนกรุงเทพฯเรียกหามาโดยตลอด คือ การเปลี่ยนรถเมล์ใหม่ทั้งหมด และยกระดับการให้บริการให้ดีขึ้นกว่าที่เคยเป็น",
      urlToImage:
          "https://www.thebangkokinsight.com/wp-content/uploads/2020/06/%E0%B8%82%E0%B8%B2%E0%B8%94%E0%B8%97%E0%B8%B8%E0%B8%99-%E0%B8%82%E0%B8%AA%E0%B8%A1%E0%B8%81-01-scaled.jpg",
      articleUrl:
          "https://www.thebangkokinsight.com/wp-content/uploads/2020/06/%E0%B8%82%E0%B8%B2%E0%B8%94%E0%B8%97%E0%B8%B8%E0%B8%99-%E0%B8%82%E0%B8%AA%E0%B8%A1%E0%B8%81-01-scaled.jpg",
    ),
    Article(
      title:
          "เปิดแผน ‘รถเมล์ใหม่’ 7,200 คัน ‘ขสมก.-พลังงานบริสุทธิ์’ การันตี 3 ปี รถใหม่พรึ่บ",
      content:
          "แม้ปัจจุบันเมืองฟ้าอมรจะมีระบบขนส่งสาธารณะให้เลือกใช้มากมาย ทั้งรถไฟฟ้าลอยฟ้า รถไฟฟ้าใต้ดิน เรือโดยสารตามคลองต่างๆ หรือวินจักรยานยนต์ ตามจุดแยกย่อยทั่วกรุงเทพฯ แต่รถเมล์ หรือในชื่อทางการ ‘รถโดยสารประจำทาง’ ยังคงเป็นรถโดยสารสาธารณะที่มีผู้ใช้งานมากที่สุด",
      description:
          "ปัญหาหนึ่งของรถเมล์ไทยคือ มีสภาพเก่า บางคันใช้งานมามากกว่า 30 ปี รวมถึงปัญหาอื่นๆที่กลายเป็นความเคยชินไปแล้ว เช่น ปัญหาควันดำ, PM2.5 , เสียงดัง, การขับขี่ที่ไม่ปลอดภัย น่าหวาดเสียว, รอนาน , ไม่สะอาด ปัญหาการให้บริการ, เสียค่าเดินทางหลายทอด เป็นต้น ดังนั้น สิ่งที่คนกรุงเทพฯเรียกหามาโดยตลอด คือ การเปลี่ยนรถเมล์ใหม่ทั้งหมด และยกระดับการให้บริการให้ดีขึ้นกว่าที่เคยเป็น",
      urlToImage:
          "https://www.tnnthailand.com/static/images/46191acf-7bcd-4a19-abeb-389d8f0a72dd.jpg",
      articleUrl:
          "https://www.tnnthailand.com/static/images/46191acf-7bcd-4a19-abeb-389d8f0a72dd.jpg",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 235, 240, 244),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    Color.fromARGB(255, 34, 50, 174),
                    Color.fromARGB(255, 37, 43, 99),
                  ]),
            ),
          ),
          // backgroundColor: colorBar,
          title: const Text('ข่าวสาร'),
          centerTitle: true,
          actions: <Widget>[],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 16),
        child: ListView.builder(
            itemCount: listNews.length,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return NewsTile(
                imgUrl: listNews[index].urlToImage,
                title: listNews[index].title,
                desc: listNews[index].description,
                content: listNews[index].content,
                posturl: listNews[index].urlToImage,
              );
            }),
      ),
    );
  }
}
