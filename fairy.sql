SET NAMES UTF8;
DROP DATABASE IF EXISTS fairy;
CREATE DATABASE fairy CHARSET=UTF8;
USE fairy;

/**用户信息**/
CREATE TABLE sc_user(
  uid INT PRIMARY KEY AUTO_INCREMENT,
  uname VARCHAR(32),
  upwd VARCHAR(32),
  email VARCHAR(64),
  phone VARCHAR(16),

  avatar VARCHAR(128)  DEFAULT  'img/avatar/default.png',        #头像图片路径
  user_name VARCHAR(32),      #用户名，如王小明
  gender INT                  #性别  0-女  1-男
);

/**购物车条目**/
CREATE TABLE sc_shoppingcart_item(
  iid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,      #用户编号
  product_id INT,   #商品编号
  count INT,        #购买数量
  is_checked BOOLEAN #是否已勾选，确定购买
);


#/**收货地址信息**/
CREATE TABLE sc_receiver_address(
  aid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,                #用户编号
  receiver VARCHAR(16),       #接收人姓名
  province VARCHAR(16),       #省
  city VARCHAR(16),           #市
  county VARCHAR(16),         #县
  address VARCHAR(128),       #详细地址
  cellphone VARCHAR(16),      #手机
  postcode CHAR(6),           #邮编
  is_default BOOLEAN          #是否为当前用户的默认收货地址
);
INSERT INTO sc_receiver_address VALUES(NULL,1,'文华','陕西省','西安市','碑林区','长安大街3号','13912356852','030020',true);
INSERT INTO sc_receiver_address VALUES(NULL,2,'当当','陕西省','西安市','雁塔区','东仪路3号建设一行','15245679862','030020',true);
INSERT INTO sc_receiver_address VALUES(NULL,2,'Tom','陕西省','西安市','碑林区','长安大街3号山下水泥厂','15492252656','030020',false);

/**用户订单**/
CREATE TABLE sc_order(
  aid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,		  #用户id
  order_id BIGINT,        #订单编号
  product_id INT,         #产品编号
  payPrice  INT,	  #付款金额
  count INT ,             #购买数量
  address_id INT,         #地址编号
  status INT,             #订单状态  1-等待付款  2-等待发货  3-运输中  4-已签收  5-已取消
  order_time BIGINT,      #下单时间
  pay_time BIGINT,        #付款时间
  deliver_time BIGINT,    #发货时间
  received_time BIGINT    #签收时间
);







/****首页轮播广告商品****/
CREATE TABLE sc_index_carousel(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  img VARCHAR(128),
  title VARCHAR(64),
  href VARCHAR(128)
);

/****首页秒杀商品****/
CREATE TABLE sc_index_seckill_product(
  sid INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(64),
  pic VARCHAR(128),
  price DECIMAL(10,2),
  old_price DECIMAL(10,2),
  href VARCHAR(128),
  eid INT
);


/****首页楼层商品****/
CREATE TABLE sc_floor_product(
  pid INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(64),			#标题
  details VARCHAR(128),			#详情
  pic VARCHAR(128),			#图片
  price DECIMAL(10,2),			#价格
  href VARCHAR(128),			#链接
  brand  VARCHAR(128),                  #品牌
  number_sold  INT,			#已售数量
  sequence  INT	,			#排序
  eid INT
);


/**手机品牌家族**/
CREATE TABLE sc_phone_family(
  fid INT PRIMARY KEY AUTO_INCREMENT,
  fname VARCHAR(32),
  phonePic  VARCHAR(2048),     #图片
  brandPic  VARCHAR(1024)      #品牌图片
);

/**手机型号**/
CREATE TABLE sc_phone(
  lid INT PRIMARY KEY AUTO_INCREMENT,
  family_id INT,              #所属型号家族编号
  title VARCHAR(128),         #主标题
  subtitle VARCHAR(128),      #副标题
  price DECIMAL(10,2),        #价格
  promotion VARCHAR(64),      #促销活动
  RAM VARCHAR(64),            #运存
  ROM VARCHAR(64),            #内存容量
  color  VARCHAR(64),         #颜色
  color_num INT,              #颜色编号
  
  name VARCHAR(64),	      #手机名称1
  productor  VARCHAR(64),     #手机厂家2
  			      #产地3origin  VARCHAR(64)
  size  VARCHAR(64),          #尺寸4
			      #颜色5
  system  VARCHAR(64)       #系统6
 
  
  
);

/**手机图片**/
CREATE TABLE sc_phone_pic(
  pid INT PRIMARY KEY AUTO_INCREMENT,
  color_id INT,               #颜色编号
  sm VARCHAR(128),            #小图片路径
  md VARCHAR(128),            #中图片路径
  lg VARCHAR(128)             #大图片路径
);


/**详情页推荐**/
CREATE TABLE sc_recommend_product(
  rid INT PRIMARY KEY AUTO_INCREMENT,    #推荐商品rid
  title VARCHAR(64),			 #标题
  pic VARCHAR(128),			#图片
  href VARCHAR(128)			#跳转路径
);



/*******************/
/******数据导入******/
/*******************/
/****首页轮播广告商品****/
INSERT INTO sc_index_carousel VALUES(NULL, 'img/index/banner1.jpg','轮播广告商品1','product-details.html?lid=79');
INSERT INTO sc_index_carousel VALUES(NULL, 'img/index/banner2.jpg','轮播广告商品2','product-details.html?lid=47');
INSERT INTO sc_index_carousel VALUES(NULL, 'img/index/banner3.jpg','轮播广告商品3','product-details.html?lid=41');
INSERT INTO sc_index_carousel VALUES(NULL, 'img/index/banner4.jpg','轮播广告商品4','product-details.html?lid=19');

/****首页秒杀商品****/
INSERT INTO sc_index_seckill_product VALUES(null,'华为手机Mate10(ALP-AL00) 4GB+64GB 全网通 双卡双待 樱粉金','img/product/md/HUAWEIMate10(ALP-AL00)pink1.jpg','3899.00','4099.00','product-details.html?lid=25',25);
INSERT INTO sc_index_seckill_product VALUES(null,'vivo X20 4GB+64GB 移动联通电信4G手机 双卡双待 玫瑰金','img/product/md/vivoX20Apink1.jpg','2998.00','2098.00','product-details.html?lid=47',47);
INSERT INTO sc_index_seckill_product VALUES(null,'小米Note3 全网通版 6GB+64GB 亮蓝 移动联通电信4G手机 双卡双待','img/product/md/MINote3blue1.jpg','2499.00','2499.00','product-details.html?lid=39',39);
INSERT INTO sc_index_seckill_product VALUES(null,'OPPO R11 4GB+64GB 4G手机 全网通 双卡双待手机 红色','img/product/md/OPPOR11red1.jpg','2799.00','2799.00','product-details.html?lid=33',33);
INSERT INTO sc_index_seckill_product VALUES(null,'荣耀（honor）荣耀9 标配版 4GB+64GB 全网通版 琥珀金','img/product/md/Honor(honor9)gold1.jpg','2299.00','2299.00','product-details.html?lid=52',52);



/**手机家族**/
INSERT INTO sc_phone_family VALUES(NULL,'SAMSUNG Galaxy S8/S8 Plus','<img src="img/product/detail/GalaxyS8/GalaxyS8(0).jpeg"><img src="img/product/detail/GalaxyS8/GalaxyS8(1).jpeg"><img src="img/product/detail/GalaxyS8/GalaxyS8(2).jpeg"><img src="img/product/detail/GalaxyS8/GalaxyS8(3)1.jpg"><img src="img/product/detail/GalaxyS8/GalaxyS8(3).jpeg"><img src="img/product/detail/GalaxyS8/GalaxyS8(4).jpeg"><img src="img/product/detail/GalaxyS8/GalaxyS8(4)1.jpg"><img src="img/product/detail/GalaxyS8/GalaxyS8(4)4.jpg"><img src="img/product/detail/GalaxyS8/GalaxyS8(4)3.jpg"><img src="img/product/detail/GalaxyS8/GalaxyS8(8).jpeg"><img src="img/product/detail/GalaxyS8/GalaxyS8(9).jpeg"><img src="img/product/detail/GalaxyS8/GalaxyS8(10).jpeg"><img src="img/product/detail/GalaxyS8/GalaxyS8(11).jpeg"><img src="img/product/detail/GalaxyS8/GalaxyS8(12).jpeg"><img src="img/product/detail/GalaxyS8/GalaxyS8(13).jpeg"><img src="img/product/detail/GalaxyS8/GalaxyS8(14).jpeg">','<img src="img/product/detail/GalaxyS8/samsung.jpg">');
INSERT INTO sc_phone_family VALUES(NULL,'HUAWEI Mate10','<img src="img/product/detail/huawei/Mate10(ALP-AL00)black1.jpg" ><img src="img/product/detail/huawei/Mate10(ALP-AL00)black2.jpg" ><img src="img/product/detail/huawei/Mate10(ALP-AL00)black3.jpg" ><img src="img/product/detail/huawei/Mate10(ALP-AL00)black4.jpg" ><img src="img/product/detail/huawei/Mate10(ALP-AL00)black5.jpg" ><img src="img/product/detail/huawei/Mate10(ALP-AL00)black6.jpg" ><img src="img/product/detail/huawei/Mate10(ALP-AL00)black7.jpg" ><img src="img/product/detail/huawei/Mate10(ALP-AL00)black8.jpg" >','<img src="img/product/detail/huawei/huawei.jpg">');
INSERT INTO sc_phone_family VALUES(NULL,'OPPO R11','<img src="img/product/detail/oppo/OPPOR11red1.jpg"><img src="img/product/detail/oppo/OPPOR11red2.jpg"><img src="img/product/detail/oppo/OPPOR11red3.jpg"><img src="img/product/detail/oppo/OPPOR11red4.jpg"><img src="img/product/detail/oppo/OPPOR11red5.jpg"><img src="img/product/detail/oppo/OPPOR11red6.jpg"><img src="img/product/detail/oppo/OPPOR11red7.jpg"><img src="img/product/detail/oppo/OPPOR11red8.jpg"><img src="img/product/detail/oppo/OPPOR11red9.jpg"><img src="img/product/detail/oppo/OPPOR11red10.jpg"><img src="img/product/detail/oppo/OPPOR11red11.jpg"><img src="img/product/detail/oppo/OPPOR11red12.jpg"><img src="img/product/detail/oppo/OPPOR11red13.jpg"><img src="img/product/detail/oppo/OPPOR11red14.jpg"><img src="img/product/detail/oppo/OPPOR11red15.jpg"><img src="img/product/detail/oppo/OPPOR11red16.jpg"><img src="img/product/detail/oppo/OPPOR11red17.jpg">','<img src="img/product/detail/oppo/OPPO.jpg">');
INSERT INTO sc_phone_family VALUES(NULL,'MI note3','<img src="img/product/detail/xiaomi/xiaomiNote31.jpg"><img src="img/product/detail/xiaomi/xiaomiNote32.jpg"><img src="img/product/detail/xiaomi/xiaomiNote33.jpg"><img src="img/product/detail/xiaomi/xiaomiNote34.jpg"><img src="img/product/detail/xiaomi/xiaomiNote35.jpg"><img src="img/product/detail/xiaomi/xiaomiNote36.jpg"><img src="img/product/detail/xiaomi/xiaomiNote37.jpg"><img src="img/product/detail/xiaomi/xiaomiNote38.jpg"><img src="img/product/detail/xiaomi/xiaomiNote39.jpg"><img src="img/product/detail/xiaomi/xiaomiNote310.jpg"><img src="img/product/detail/xiaomi/xiaomiNote311.jpg"><img src="img/product/detail/xiaomi/xiaomiNote312.jpg"><img src="img/product/detail/xiaomi/xiaomiNote313.jpg"><img src="img/product/detail/xiaomi/xiaomiNote314.jpg"><img src="img/product/detail/xiaomi/xiaomiNote315.jpg"><img src="img/product/detail/xiaomi/xiaomiNote316.jpg"><img src="img/product/detail/xiaomi/xiaomiNote317.jpg"><img src="img/product/detail/xiaomi/xiaomiNote318.jpg"><img src="img/product/detail/xiaomi/xiaomiNote319.jpg"><img src="img/product/detail/xiaomi/xiaomiNote320.jpg">' ,'<img src="img/product/detail/xiaomi/xiaomi.jpg">');
INSERT INTO sc_phone_family VALUES(NULL,'Apple X','<img src="img/product/detail/apple/iPhoneX1.jpg"><img src="img/product/detail/apple/iPhoneX2.jpg"><img src="img/product/detail/apple/iPhoneX3.jpg"><img src="img/product/detail/apple/iPhoneX4.jpg"><img src="img/product/detail/apple/iPhoneX5.jpg"><img src="img/product/detail/apple/iPhoneX6.jpg"><img src="img/product/detail/apple/iPhoneX7.jpg"><img src="img/product/detail/apple/iPhoneX8.jpg"><img src="img/product/detail/apple/iPhoneX9.jpg"><img src="img/product/detail/apple/iPhoneX10.jpg"><img src="img/product/detail/apple/iPhoneX12.jpg"><img src="img/product/detail/apple/iPhoneX13.jpg"><img src="img/product/detail/apple/iPhoneX14.jpg"><img src="img/product/detail/apple/iPhoneX15.jpg"><img src="img/product/detail/apple/iPhoneX16.jpg"><img src="img/product/detail/apple/iPhoneX17.jpg"><img src="img/product/detail/apple/iPhoneX18.jpg"><img src="img/product/detail/apple/iPhoneX19.jpg"><img src="img/product/detail/apple/iPhoneX20.jpg"><img src="img/product/detail/apple/iPhoneX21.jpg"><img src="img/product/detail/apple/iPhoneX22.jpg"><img src="img/product/detail/apple/iPhoneX23.jpg"><img src="img/product/detail/apple/iPhoneX24.jpg"><img src="img/product/detail/apple/iPhoneX25.jpg">','<img src="img/product/detail/apple/apple.jpg">');
INSERT INTO sc_phone_family VALUES(NULL,'VIVO X20','<img src="img/product/detail/vivo/vivoX20A1.jpg"><img src="img/product/detail/vivo/vivoX20A2.jpg"><img src="img/product/detail/vivo/vivoX20A3.jpg"><img src="img/product/detail/vivo/vivoX20A4.jpg"><img src="img/product/detail/vivo/vivoX20A5.jpg"><img src="img/product/detail/vivo/vivoX20A6.jpg"><img src="img/product/detail/vivo/vivoX20A7.jpg"><img src="img/product/detail/vivo/vivoX20A8.jpg"><img src="img/product/detail/vivo/vivoX20A9.jpg"><img src="img/product/detail/vivo/vivoX20A10.jpg"><img src="img/product/detail/vivo/vivoX20A11.jpg"><img src="img/product/detail/vivo/vivoX20A12.jpg"><img src="img/product/detail/vivo/vivoX20A13.jpg"><img src="img/product/detail/vivo/vivoX20A14.jpg"><img src="img/product/detail/vivo/vivoX20A15.jpg"><img src="img/product/detail/vivo/vivoX20A16.jpg">','<img src="img/product/detail/vivo/vivo.jpg">');
INSERT INTO sc_phone_family VALUES(NULL,'Honor 9','<img src="img/product/detail/honor/honor9gray1.jpg"><img src="img/product/detail/honor/honor9gray2.jpg"><img src="img/product/detail/honor/honor9gray3.jpg"><img src="img/product/detail/honor/honor9gray4.jpg"><img src="img/product/detail/honor/honor9gray5.jpg"><img src="img/product/detail/honor/honor9gray6.jpg"><img src="img/product/detail/honor/honor9gray7.jpg"><img src="img/product/detail/honor/honor9gray8.jpg"><img src="img/product/detail/honor/honor9gray10.jpg"><img src="img/product/detail/honor/honor9gray11.jpg"><img src="img/product/detail/honor/honor9gray12.jpg"><img src="img/product/detail/honor/honor9gray13.jpg"><img src="img/product/detail/honor/honor9gray14.jpg"><img src="img/product/detail/honor/honor9gray15.jpg"><img src="img/product/detail/honor/honor9gray16.jpg"><img src="img/product/detail/honor/honor9gray17.jpg"><img src="img/product/detail/honor/honor9gray18.jpg"><img src="img/product/detail/honor/honor9gray19.jpg"><img src="img/product/detail/honor/honor9gray20.jpg"><img src="img/product/detail/honor/honor9gray21.jpg">','<img src="img/product/detail/honor/honor.jpg">');
INSERT INTO sc_phone_family VALUES(NULL,'HUAWEI nova2','<img src="img/product/detail/nova2/HUAWEInova2Plus1.jpg"><img src="img/product/detail/nova2/HUAWEInova2Plus2.jpg"><img src="img/product/detail/nova2/HUAWEInova2Plus3.jpg"><img src="img/product/detail/nova2/HUAWEInova2Plus4.jpg"><img src="img/product/detail/nova2/HUAWEInova2Plus5.jpg"><img src="img/product/detail/nova2/HUAWEInova2Plus6.jpg"><img src="img/product/detail/nova2/HUAWEInova2Plus7.jpg"><img src="img/product/detail/nova2/HUAWEInova2Plus8.jpg"><img src="img/product/detail/nova2/HUAWEInova2Plus9.jpg"><img src="img/product/detail/nova2/HUAWEInova2Plus10.jpg"><img src="img/product/detail/nova2/HUAWEInova2Plus11.jpg"><img src="img/product/detail/nova2/HUAWEInova2Plus12.jpg"><img src="img/product/detail/nova2/HUAWEInova2Plus13.jpg"><img src="img/product/detail/nova2/HUAWEInova2Plus14.jpg"><img src="img/product/detail/nova2/HUAWEInova2Plus15.jpg">','<img src="img/product/detail/huawei/huawei.jpg">');

INSERT INTO sc_phone_family VALUES(NULL,'HUAWEI Mate9 Pro','<img src="img/product/detail/mate9/01.jpg"><img src="img/product/detail/mate9/02.jpg"><img src="img/product/detail/mate9/03.jpg"><img src="img/product/detail/mate9/04.jpg"><img src="img/product/detail/mate9/05.jpg"><img src="img/product/detail/mate9/06.jpg"><img src="img/product/detail/mate9/07.jpg"><img src="img/product/detail/mate9/08.jpg"><img src="img/product/detail/mate9/09.jpg"><img src="img/product/detail/mate9/10.jpg"><img src="img/product/detail/mate9/11.jpg"><img src="img/product/detail/mate9/12.jpg"><img src="img/product/detail/mate9/13.jpg"><img src="img/product/detail/mate9/14.jpg"><img src="img/product/detail/mate9/15.jpg"><img src="img/product/detail/mate9/16.jpg"><img src="img/product/detail/mate9/17.jpg"><img src="img/product/detail/mate9/18.jpg"><img src="img/product/detail/mate9/19.jpg"><img src="img/product/detail/mate9/20.jpg"><img src="img/product/detail/mate9/21.jpg"><img src="img/product/detail/mate9/22.jpg"><img src="img/product/detail/mate9/23.jpg"><img src="img/product/detail/mate9/24.jpg"><img src="img/product/detail/mate9/25.jpg">','<img src="img/product/detail/huawei/huawei.jpg">');

INSERT INTO sc_phone_family VALUES(NULL,'HUAWEI P10 Plus','<img src="img/product/detail/p10Plus/01.jpg"><img src="img/product/detail/p10Plus/02.jpg"><img src="img/product/detail/p10Plus/03.jpg"><img src="img/product/detail/p10Plus/04.jpg"><img src="img/product/detail/p10Plus/05.jpg"><img src="img/product/detail/p10Plus/06.jpg"><img src="img/product/detail/p10Plus/07.jpg"><img src="img/product/detail/p10Plus/08.jpg"><img src="img/product/detail/p10Plus/09.jpg"><img src="img/product/detail/p10Plus/10.jpg"><img src="img/product/detail/p10Plus/11.jpg"><img src="img/product/detail/p10Plus/12.jpg"><img src="img/product/detail/p10Plus/13.jpg"><img src="img/product/detail/p10Plus/14.jpg"><img src="img/product/detail/p10Plus/15.jpg">','<img src="img/product/detail/huawei/huawei.jpg">');

INSERT INTO sc_phone_family VALUES(NULL,'华为畅享7','<img src="img/product/detail/changxiang7/01.jpg"><img src="img/product/detail/changxiang7/02.jpg"><img src="img/product/detail/changxiang7/03.jpg"><img src="img/product/detail/changxiang7/04.jpg"><img src="img/product/detail/changxiang7/05.jpg"><img src="img/product/detail/changxiang7/06.jpg"><img src="img/product/detail/changxiang7/07.jpg"><img src="img/product/detail/changxiang7/08.jpg"><img src="img/product/detail/changxiang7/09.jpg">','<img src="img/product/detail/huawei/huawei.jpg">');

INSERT INTO sc_phone_family VALUES(NULL,'HUAWEI 麦芒5','<img src="img/product/detail/maimang5/01.jpg"><img src="img/product/detail/maimang5/02.jpg"><img src="img/product/detail/maimang5/03.jpg"><img src="img/product/detail/maimang5/04.jpg"><img src="img/product/detail/maimang5/05.jpg"><img src="img/product/detail/maimang5/06.jpg"><img src="img/product/detail/maimang5/07.jpg"><img src="img/product/detail/maimang5/08.jpg"><img src="img/product/detail/maimang5/09.jpg"><img src="img/product/detail/maimang5/10.jpg">','<img src="img/product/detail/huawei/huawei.jpg">');


#N8
INSERT INTO sc_phone_family VALUES(NULL,'SAMSUNG Galaxy N8','<img src="img/product/detail/N8/01.jpg"><img src="img/product/detail/N8/02.jpg"><img src="img/product/detail/N8/03.jpg"><img src="img/product/detail/N8/04.jpg"><img src="img/product/detail/N8/05.jpg"><img src="img/product/detail/N8/06.jpg"><img src="img/product/detail/N8/07.jpg"><img src="img/product/detail/N8/08.jpg"><img src="img/product/detail/N8/09.jpg"><img src="img/product/detail/N8/10.jpg">','<img src="img/product/detail/samsung.jpg">');

#C8
INSERT INTO sc_phone_family VALUES(NULL,'SAMSUNG Galaxy C8','<img src="img/product/detail/GalaxyC8/01.jpg"><img src="img/product/detail/GalaxyC8/03.jpg"><img src="img/product/detail/GalaxyC8/03.jpg"><img src="img/product/detail/GalaxyC8/04.jpg"><img src="img/product/detail/GalaxyC8/05.jpg"><img src="img/product/detail/GalaxyC8/06.jpg"><img src="img/product/detail/GalaxyC8/07.jpg"><img src="img/product/detail/GalaxyC8/08.jpg"><img src="img/product/detail/GalaxyC8/09.jpg"><img src="img/product/detail/GalaxyC8/10.jpg"><img src="img/product/detail/GalaxyC8/11.jpg"><img src="img/product/detail/GalaxyC8/12.jpg"><img src="img/product/detail/GalaxyC8/13.jpg"><img src="img/product/detail/GalaxyC8/14.jpg"><img src="img/product/detail/GalaxyC8/15.jpg">','<img src="img/product/detail/samsung.jpg">');



#C7
INSERT INTO sc_phone_family VALUES(NULL,'SAMSUNG Galaxy C7 Pro','<img src="img/product/detail/GalaxyC7/01.jpg"><img src="img/product/detail/GalaxyC7/02.jpg"><img src="img/product/detail/GalaxyC7/03.jpg"><img src="img/product/detail/GalaxyC7/04.jpg"><img src="img/product/detail/GalaxyC7/05.jpg"><img src="img/product/detail/GalaxyC7/08.jpg"><img src="img/product/detail/GalaxyC7/09.jpg"><img src="img/product/detail/GalaxyC7/10.jpg"><img src="img/product/detail/GalaxyC7/11.jpg"><img src="img/product/detail/GalaxyC7/12.jpg"><img src="img/product/detail/GalaxyC7/13.jpg"><img src="img/product/detail/GalaxyC7/14.jpg"><img src="img/product/detail/GalaxyC7/15.jpg"><img src="img/product/detail/GalaxyC7/16.jpg"><img src="img/product/detail/GalaxyC7/17.jpg"><img src="img/product/detail/GalaxyC7/18.jpg"><img src="img/product/detail/GalaxyC7/19.jpg"><img src="img/product/detail/GalaxyC7/20.jpg">','<img src="img/product/detail/samsung.jpg">');

#j3
INSERT INTO sc_phone_family VALUES(NULL,'SAMSUNG Galaxy J3','<img src="img/product/detail/GalaxyJ3/01.jpg"><img src="img/product/detail/GalaxyJ3/02.jpg"><img src="img/product/detail/GalaxyJ3/03.jpg"><img src="img/product/detail/GalaxyJ3/04.jpg"><img src="img/product/detail/GalaxyJ3/05.jpg"><img src="img/product/detail/GalaxyJ3/06.jpg"><img src="img/product/detail/GalaxyJ3/07.jpg"><img src="img/product/detail/GalaxyJ3/08.jpg"><img src="img/product/detail/GalaxyJ3/09.jpg"><img src="img/product/detail/GalaxyJ3/10.jpg"><img src="img/product/detail/GalaxyJ3/11.jpg"><img src="img/product/detail/GalaxyJ3/12.jpg"><img src="img/product/detail/GalaxyJ3/13.jpg"><img src="img/product/detail/GalaxyJ3/14.jpg"><img src="img/product/detail/GalaxyJ3/15.jpg"><img src="img/product/detail/GalaxyJ3/16.jpg"><img src="img/product/detail/GalaxyJ3/17.jpg"><img src="img/product/detail/GalaxyJ3/18.jpg"><img src="img/product/detail/GalaxyJ3/19.jpg"><img src="img/product/detail/GalaxyJ3/20.jpg"><img src="img/product/detail/GalaxyJ3/21.jpg"><img src="img/product/detail/GalaxyJ3/22.jpg"><img src="img/product/detail/GalaxyJ3/23.jpg"><img src="img/product/detail/GalaxyJ3/24.jpg"><img src="img/product/detail/GalaxyJ3/25.jpg"><img src="img/product/detail/GalaxyJ3/26.jpg"><img src="img/product/detail/GalaxyJ3/27.jpg"><img src="img/product/detail/GalaxyJ3/28.jpg"><img src="img/product/detail/GalaxyJ3/29.jpg">','<img src="img/product/detail/samsung.jpg">');
#C9 Pro
INSERT INTO sc_phone_family VALUES(NULL,'SAMSUNG Galaxy C9 Pro','<img src="img/product/detail/C9/01.jpg"><img src="img/product/detail/C9/02.jpg">
<img src="img/product/detail/C9/03.jpg"><img src="img/product/detail/C9/04.jpg"><img src="img/product/detail/C9/05.jpg"><img src="img/product/detail/C9/06.jpg"><img src="img/product/detail/C9/07.jpg"><img src="img/product/detail/C9/017.jpg"><img src="img/product/detail/C9/08.jpg"><img src="img/product/detail/C9/09.jpg"><img src="img/product/detail/C9/11.jpg"><img src="img/product/detail/C9/12.jpg"><img src="img/product/detail/C9/13.jpg"><img src="img/product/detail/C9/14.jpg"><img src="img/product/detail/C9/15.jpg"><img src="img/product/detail/C9/16.jpg"><img src="img/product/detail/C9/17.jpg"><img src="img/product/detail/C9/18.jpg"><img src="img/product/detail/C9/19.jpg"><img src="img/product/detail/C9/20.jpg">','<img src="img/product/detail/samsung.jpg">');

#a59s
INSERT INTO sc_phone_family VALUES(NULL,'OPPO A59s','<img src="img/product/detail/a59s/01.jpg"><img src="img/product/detail/a59s/02.jpg"><img src="img/product/detail/a59s/03.jpg"><img src="img/product/detail/a59s/04.jpg"><img src="img/product/detail/a59s/05.jpg"><img src="img/product/detail/a59s/06.jpg"><img src="img/product/detail/a59s/07.jpg"><img src="img/product/detail/a59s/08.jpg"><img src="img/product/detail/a59s/09.jpg"><img src="img/product/detail/a59s/10.jpg"><img src="img/product/detail/a59s/11.jpg"><img src="img/product/detail/a59s/12.jpg"><img src="img/product/detail/a59s/13.jpg"><img src="img/product/detail/a59s/14.jpg"><img src="img/product/detail/a59s/15.jpg"><img src="img/product/detail/a59s/16.jpg"><img src="img/product/detail/a59s/17.jpg"><img src="img/product/detail/a59s/18.jpg"><img src="img/product/detail/a59s/19.jpg"><img src="img/product/detail/a59s/21.jpg"><img src="img/product/detail/a59s/22.jpg"><img src="img/product/detail/a59s/23.jpg"><img src="img/product/detail/a59s/24.jpg"><img src="img/product/detail/a59s/25.jpg"><img src="img/product/detail/a59s/26.jpg"><img src="img/product/detail/a59s/27.jpg"><img src="img/product/detail/a59s/28.jpg"><img src="img/product/detail/a59s/29.jpg">','<img src="img/product/detail/oppo/OPPO.jpg">>');
#a77
INSERT INTO sc_phone_family VALUES(NULL,'OPPO A77','<img src="img/product/detail/a77/01.jpg"><img src="img/product/detail/a77/02.jpg"><img src="img/product/detail/a77/03.jpg"><img src="img/product/detail/a77/04.jpg"><img src="img/product/detail/a77/05.jpg"><img src="img/product/detail/a77/06.jpg"><img src="img/product/detail/a77/07.jpg"><img src="img/product/detail/a77/08.jpg"><img src="img/product/detail/a77/09.jpg"><img src="img/product/detail/a77/10.jpg"><img src="img/product/detail/a77/11.jpg"><img src="img/product/detail/a77/12.jpg">','<img src="img/product/detail/oppo/OPPO.jpg">>');
#a57
INSERT INTO sc_phone_family VALUES(NULL,'OPPO A57','<img src="img/product/detail/a57/01.jpg"><img src="img/product/detail/a77/01.jpg"><img src="img/product/detail/a77/02.jpg"><img src="img/product/detail/a77/03.jpg"><img src="img/product/detail/a77/04.jpg"><img src="img/product/detail/a77/05.jpg"><img src="img/product/detail/a77/06.jpg"><img src="img/product/detail/a77/07.jpg"><img src="img/product/detail/a77/08.jpg"><img src="img/product/detail/a77/09.jpg"><img src="img/product/detail/a77/11.jpg"><img src="img/product/detail/a77/12.jpg"><img src="img/product/detail/a77/13.jpg"><img src="img/product/detail/a77/14.jpg"><img src="img/product/detail/a77/15.jpg"><img src="img/product/detail/a77/16.jpg"><img src="img/product/detail/a77/17.jpg"><img src="img/product/detail/a77/18.jpg"><img src="img/product/detail/a77/19.jpg"><img src="img/product/detail/a77/20.jpg"><img src="img/product/detail/a77/21.jpg"><img src="img/product/detail/a77/22.jpg"><img src="img/product/detail/a77/23.jpg"><img src="img/product/detail/a77/24.jpg"><img src="img/product/detail/a77/25.jpg"><img src="img/product/detail/a77/25.jpg">','<img src="img/product/detail/oppo/OPPO.jpg">>');

#R11Plus
INSERT INTO sc_phone_family VALUES(NULL,'OPPO R11Plus','<img src="img/product/detail/R11Plus/01.jpg"><img src="img/product/detail/R11Plus/02.jpg"><img src="img/product/detail/R11Plus/03.jpg"><img src="img/product/detail/R11Plus/04.jpg"><img src="img/product/detail/R11Plus/05.jpg"><img src="img/product/detail/R11Plus/06.jpg"><img src="img/product/detail/R11Plus/07.jpg"><img src="img/product/detail/R11Plus/08.jpg"><img src="img/product/detail/R11Plus/09.jpg"><img src="img/product/detail/R11Plus/11.jpg"><img src="img/product/detail/R11Plus/12.jpg"><img src="img/product/detail/R11Plus/13.jpg"><img src="img/product/detail/R11Plus/14.jpg"><img src="img/product/detail/R11Plus/15.jpg"><img src="img/product/detail/R11Plus/16.jpg"><img src="img/product/detail/R11Plus/17.jpg"><img src="img/product/detail/R11Plus/18.jpg"><img src="img/product/detail/R11Plus/19.jpg"><img src="img/product/detail/R11Plus/20.jpg"><img src="img/product/detail/R11Plus/21.jpg">','<img src="img/product/detail/oppo/OPPO.jpg">>');

#R11s
INSERT INTO sc_phone_family VALUES(NULL,'OPPO R11s','<img src="img/product/detail/R11s/01.jpg"><img src="img/product/detail/R11s/02.jpg"><img src="img/product/detail/R11s/03.jpg"><img src="img/product/detail/R11s/04.jpg"><img src="img/product/detail/R11s/05.jpg"><img src="img/product/detail/R11s/06.jpg"><img src="img/product/detail/R11s/07.jpg"><img src="img/product/detail/R11s/08.jpg"><img src="img/product/detail/R11s/09.jpg"><img src="img/product/detail/R11s/10.jpg"><img src="img/product/detail/R11s/11.jpg"><img src="img/product/detail/R11s/12.jpg">','<img src="img/product/detail/oppo/OPPO.jpg">>');


/**手机型号**/
INSERT INTO sc_phone VALUES(1,1,'三星(SAMSUNG) Galaxy S8(G9500) 全网通 手机 雾屿蓝 4G手机','【加5元，赠bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机 】三星S8+！虹膜识别，全视曲面屏，骁龙835处理器','5688.00',"满5600元另加5元，即可在购物车换购bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机",'S8','4GB+64GB','雾屿蓝','1','Galaxy S8','三星（SAMSUNG）','5.6英寸','Android');
INSERT INTO sc_phone VALUES(2,1,'三星(SAMSUNG) Galaxy S8(G9500) 全网通 手机 谜夜黑 4G手机','【加5元，赠bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机 】三星S8+！虹膜识别，全视曲面屏，骁龙835处理器','5688.00',"满5600元另加5元，即可在购物车换购bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机",'S8','4GB+64GB','谜夜黑','2','Galaxy S8','三星（SAMSUNG）','5.6英寸','Android');
INSERT INTO sc_phone VALUES(3,1,'三星(SAMSUNG) Galaxy S8(G9500) 全网通 手机 烟晶灰 4G手机','【加5元，赠bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机 】三星S8+！虹膜识别，全视曲面屏，骁龙835处理器','5688.00',"满5600元另加5元，即可在购物车换购bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机",'S8','4GB+64GB','烟晶灰','3','Galaxy S8','三星（SAMSUNG）','5.6英寸','Android');
INSERT INTO sc_phone VALUES(4,1,'三星(SAMSUNG) Galaxy S8(G9500) 全网通 手机 绮梦金 4G手机','【加5元，赠bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机 】三星S8+！虹膜识别，全视曲面屏，骁龙835处理器','5688.00',"满5600元另加5元，即可在购物车换购bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机",'S8','4GB+64GB','绮梦金','4','Galaxy S8','三星（SAMSUNG）','5.6英寸','Android');
INSERT INTO sc_phone VALUES(5,1,'三星(SAMSUNG) Galaxy S8(G9500) 全网通 手机 芭比粉 4G手机','【加5元，赠bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机 】三星S8+！虹膜识别，全视曲面屏，骁龙835处理器','5688.00',"满5600元另加5元，即可在购物车换购bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机",'S8','4GB+64GB','芭比粉','5','Galaxy S8','三星（SAMSUNG）','5.6英寸','Android');

INSERT INTO sc_phone VALUES(6,1,'三星(SAMSUNG) Galaxy S8(G9500) 全网通 手机 雾屿蓝 4G手机','【加5元，赠bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机 】三星S8+！虹膜识别，全视曲面屏，骁龙835处理器','5688.00',"满5600元另加5元，即可在购物车换购bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机",'S8','6GB+128G','雾屿蓝','1','Galaxy S8','三星（SAMSUNG）','5.6英寸','Android');
INSERT INTO sc_phone VALUES(7,1,'三星(SAMSUNG) Galaxy S8(G9500) 全网通 手机 谜夜黑 4G手机','【加5元，赠bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机 】三星S8+！虹膜识别，全视曲面屏，骁龙835处理器','5688.00',"满5600元另加5元，即可在购物车换购bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机",'S8','6GB+128G','谜夜黑','2','Galaxy S8','三星（SAMSUNG）','5.6英寸','Android');
INSERT INTO sc_phone VALUES(8,1,'三星(SAMSUNG) Galaxy S8(G9500) 全网通 手机 烟晶灰 4G手机','【加5元，赠bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机 】三星S8+！虹膜识别，全视曲面屏，骁龙835处理器','5688.00',"满5600元另加5元，即可在购物车换购bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机",'S8','6GB+128G','烟晶灰','3','Galaxy S8','三星（SAMSUNG）','5.6英寸','Android');
INSERT INTO sc_phone VALUES(9,1,'三星(SAMSUNG) Galaxy S8(G9500) 全网通 手机 绮梦金 4G手机','【加5元，赠bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机 】三星S8+！虹膜识别，全视曲面屏，骁龙835处理器','5688.00',"满5600元另加5元，即可在购物车换购bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机",'S8','6GB+128G','绮梦金','4','Galaxy S8','三星（SAMSUNG）','5.6英寸','Android');
INSERT INTO sc_phone VALUES(10,1,'三星(SAMSUNG) Galaxy S8(G9500) 全网通 手机 芭比粉 4G手机','【加5元，赠bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机 】三星S8+！虹膜识别，全视曲面屏，骁龙835处理器','5688.00',"满5600元另加5元，即可在购物车换购bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机",'S8','6GB+128G','芭比粉','5','Galaxy S8','三星（SAMSUNG）','5.6英寸','Android');

INSERT INTO sc_phone VALUES(11,1,'三星(SAMSUNG) Galaxy S8 Plus(G9550) 全网通 手机 雾屿蓝 4G手机','【加5元，赠bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机 】三星S8+！虹膜识别，全视曲面屏，骁龙835处理器','6188.00',"满5600元另加5元，即可在购物车换购bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机",'S8 Plus','4GB+64GB','雾屿蓝','1','Galaxy S8 Plus','三星（SAMSUNG）','6.1英寸','Android');
INSERT INTO sc_phone VALUES(12,1,'三星(SAMSUNG) Galaxy S8 Plus(G9550) 全网通 手机 谜夜黑 4G手机','【加5元，赠bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机 】三星S8+！虹膜识别，全视曲面屏，骁龙835处理器','6188.00',"满5600元另加5元，即可在购物车换购bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机",'S8 Plus','4GB+64GB','谜夜黑','2','Galaxy S8 Plus','三星（SAMSUNG）','6.1英寸','Android');
INSERT INTO sc_phone VALUES(13,1,'三星(SAMSUNG) Galaxy S8 Plus(G9550) 全网通 手机 烟晶灰 4G手机','【加5元，赠bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机 】三星S8+！虹膜识别，全视曲面屏，骁龙835处理器','6188.00',"满5600元另加5元，即可在购物车换购bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机",'S8 Plus','4GB+64GB','烟晶灰','3','Galaxy S8 Plus','三星（SAMSUNG）','6.1英寸','Android');
INSERT INTO sc_phone VALUES(14,1,'三星(SAMSUNG) Galaxy S8 Plus(G9550) 全网通 手机 绮梦金 4G手机','【加5元，赠bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机 】三星S8+！虹膜识别，全视曲面屏，骁龙835处理器','6188.00',"满5600元另加5元，即可在购物车换购bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机",'S8 Plus','4GB+64GB','绮梦金','4','Galaxy S8 Plus','三星（SAMSUNG）','6.1英寸','Android');
INSERT INTO sc_phone VALUES(15,1,'三星(SAMSUNG) Galaxy S8 Plus(G9550) 全网通 手机 芭比粉 4G手机','【加5元，赠bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机 】三星S8+！虹膜识别，全视曲面屏，骁龙835处理器','6188.00',"满5600元另加5元，即可在购物车换购bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机",'S8 Plus','4GB+64GB','芭比粉','5','Galaxy S8 Plus','三星（SAMSUNG）','6.1英寸','Android');


INSERT INTO sc_phone VALUES(16,1,'三星(SAMSUNG) Galaxy S8 Plus(G9550) 全网通 手机 雾屿蓝 4G手机','【加5元，赠bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机 】三星S8+！虹膜识别，全视曲面屏，骁龙835处理器','6188.00',"满5600元另加5元，即可在购物车换购bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机",'S8 Plus','6GB+128G','雾屿蓝','1','Galaxy S8 Plus','三星（SAMSUNG）','6.1英寸','Android');
INSERT INTO sc_phone VALUES(17,1,'三星(SAMSUNG) Galaxy S8 Plus(G9550) 全网通 手机 谜夜黑 4G手机','【加5元，赠bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机 】三星S8+！虹膜识别，全视曲面屏，骁龙835处理器','6188.00',"满5600元另加5元，即可在购物车换购bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机",'S8 Plus','6GB+128G','谜夜黑','2','Galaxy S8 Plus','三星（SAMSUNG）','6.1英寸','Android');
INSERT INTO sc_phone VALUES(18,1,'三星(SAMSUNG) Galaxy S8 Plus(G9550) 全网通 手机 烟晶灰 4G手机','【加5元，赠bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机 】三星S8+！虹膜识别，全视曲面屏，骁龙835处理器','6188.00',"满5600元另加5元，即可在购物车换购bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机",'S8 Plus','6GB+128G','烟晶灰','3','Galaxy S8 Plus','三星（SAMSUNG）','6.1英寸','Android');
INSERT INTO sc_phone VALUES(19,1,'三星(SAMSUNG) Galaxy S8 Plus(G9550) 全网通 手机 绮梦金 4G手机','【加5元，赠bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机 】三星S8+！虹膜识别，全视曲面屏，骁龙835处理器','6188.00',"满5600元另加5元，即可在购物车换购bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机",'S8 Plus','6GB+128G','绮梦金','4','Galaxy S8 Plus','三星（SAMSUNG）','6.1英寸','Android');
INSERT INTO sc_phone VALUES(20,1,'三星(SAMSUNG) Galaxy S8 Plus(G9550) 全网通 手机 芭比粉 4G手机','【加5元，赠bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机 】三星S8+！虹膜识别，全视曲面屏，骁龙835处理器','6188.00',"满5600元另加5元，即可在购物车换购bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机",'S8 Plus','6GB+128G','芭比粉','5','Galaxy S8 Plus','三星（SAMSUNG）','6.1英寸','Android');



#华为mate10
INSERT INTO sc_phone VALUES(NULL,2,'华为手机Mate10(ALP-AL00) 4GB+64GB 全网通 双卡双待 亮黑','麒麟970芯片！AI智能拍照！后置双f/1.6大光圈！四曲面玻璃<
华为P10加两元蓝牙耳机或手环或体脂秤>','3899.00',"满3488元另加2元，即可在购物车换购捷波朗蓝牙耳机BT2047 G黑",'全网通','4G+64G','亮黑色','6','HUAWEI Mate10','华为','5.9英寸','Android');
INSERT INTO sc_phone VALUES(NULL,2,'华为手机Mate10(ALP-AL00) 4GB+128GB 全网通 双卡双待 亮黑','麒麟970芯片！AI智能拍照！后置双f/1.6大光圈！四曲面玻璃<
华为P10加两元蓝牙耳机或手环或体脂秤>','4499.00',"满3488元另加2元，即可在购物车换购捷波朗蓝牙耳机BT2047 G黑",'全网通','6G+128G','亮黑色','6','HUAWEI Mate10','华为','5.9英寸','Android');

INSERT INTO sc_phone VALUES(NULL,2,'华为手机Mate10(ALP-AL00) 4GB+64GB 全网通 双卡双待 摩卡金','麒麟970芯片！AI智能拍照！后置双f/1.6大光圈！四曲面玻璃<
华为P10加两元蓝牙耳机或手环或体脂秤>','3899.00',"满3488元另加2元，即可在购物车换购捷波朗蓝牙耳机BT2047 G黑",'全网通','4G+64G','摩卡金','7','HUAWEI Mate10','华为','5.9英寸','Android');
INSERT INTO sc_phone VALUES(NULL,2,'华为手机Mate10(ALP-AL00) 4GB+64GB 全网通 双卡双待 摩卡金','麒麟970芯片！AI智能拍照！后置双f/1.6大光圈！四曲面玻璃<
华为P10加两元蓝牙耳机或手环或体脂秤>','4499.00',"满3488元另加2元，即可在购物车换购捷波朗蓝牙耳机BT2047 G黑",'全网通','6G+128G','摩卡金','7','HUAWEI Mate10','华为','5.9英寸','Android');

INSERT INTO sc_phone VALUES(NULL,2,'华为手机Mate10(ALP-AL00) 4GB+64GB 全网通 双卡双待 樱粉金','麒麟970芯片！AI智能拍照！后置双f/1.6大光圈！四曲面玻璃<
华为P10加两元蓝牙耳机或手环或体脂秤>','3899.00',"满3488元另加2元，即可在购物车换购捷波朗蓝牙耳机BT2047 G黑",'全网通','4G+64G','樱粉金','8','HUAWEI Mate10','华为','5.9英寸','Android');
INSERT INTO sc_phone VALUES(NULL,2,'华为手机Mate10(ALP-AL00) 4GB+64GB 全网通 双卡双待 樱粉金','麒麟970芯片！AI智能拍照！后置双f/1.6大光圈！四曲面玻璃<
华为P10加两元蓝牙耳机或手环或体脂秤>','4499.00',"满3488元另加2元，即可在购物车换购捷波朗蓝牙耳机BT2047 G黑",'全网通','6G+128G','樱粉金','8','HUAWEI Mate10','华为','5.9英寸','Android');

INSERT INTO sc_phone VALUES(NULL,2,'华为手机Mate10(ALP-AL00) 4GB+64GB 全网通 双卡双待 香槟金','麒麟970芯片！AI智能拍照！后置双f/1.6大光圈！四曲面玻璃<
华为P10加两元蓝牙耳机或手环或体脂秤>','3899.00',"满3488元另加2元，即可在购物车换购捷波朗蓝牙耳机BT2047 G黑",'全网通','4G+64G','香槟金','9','HUAWEI Mate10','华为','5.9英寸','Android');
INSERT INTO sc_phone VALUES(NULL,2,'华为手机Mate10(ALP-AL00) 4GB+64GB 全网通 双卡双待 香槟金','麒麟970芯片！AI智能拍照！后置双f/1.6大光圈！四曲面玻璃<
华为P10加两元蓝牙耳机或手环或体脂秤>','4499.00',"满3488元另加2元，即可在购物车换购捷波朗蓝牙耳机BT2047 G黑",'全网通','6G+128G','香槟金','9','HUAWEI Mate10','华为','5.9英寸','Android');


#OPPO R11
INSERT INTO sc_phone VALUES(NULL,3,'OPPO R11 4GB+64GB 4G手机 全网通 双卡双待手机 黑色','OPPO R11 5.5英寸屏幕，4GB+64GB内存，前后2000万双摄像头，骁龙处理器！R11Plus热销中！','2799.00',"满1399元另加2元，即可在购物车换购bong2s手环、小米TDS检测笔、bong智能体脂秤等",'全网通','4G+64G','亮黑色','10','OPPO R11','OPPO','5.5英寸','Android');
INSERT INTO sc_phone VALUES(NULL,3,'OPPO R11 6GB+128GB 全网通 4G手机 双卡双待手机  黑色','OPPO R11 5.5英寸屏幕，6GB+128GB内存，前后2000万双摄像头，骁龙处理器！R11Plus热销中！','3499.00',"满1399元另加2元，即可在购物车换购bong2s手环、小米TDS检测笔、bong智能体脂秤等",'全网通','6G+128G','亮黑色','10','OPPO R11','OPPO','5.5英寸','Android');

INSERT INTO sc_phone VALUES(NULL,3,'OPPO R11 4GB+64GB 4G手机 全网通 双卡双待手机 金色','OPPO R11 5.5英寸屏幕，4GB+64GB内存，前后2000万双摄像头，骁龙处理器！R11Plus热销中！','2799.00',"满1399元另加2元，即可在购物车换购bong2s手环、小米TDS检测笔、bong智能体脂秤等",'全网通','4G+64G','土豪金','11','OPPO R11','OPPO','5.5英寸','Android');
INSERT INTO sc_phone VALUES(NULL,3,'OPPO R11 6GB+128GB 全网通 4G手机 双卡双待手机  金色','OPPO R11 5.5英寸屏幕，6GB+128GB内存，前后2000万双摄像头，骁龙处理器！R11Plus热销中！','3499.00',"满1399元另加2元，即可在购物车换购bong2s手环、小米TDS检测笔、bong智能体脂秤等",'全网通','6G+128G','土豪金','11','OPPO R11','OPPO','5.5英寸','Android');

INSERT INTO sc_phone VALUES(NULL,3,'OPPO R11 4GB+64GB 4G手机 全网通 双卡双待手机 红色','OPPO R11 5.5英寸屏幕，4GB+64GB内存，前后2000万双摄像头，骁龙处理器！R11Plus热销中！','2799.00',"满1399元另加2元，即可在购物车换购bong2s手环、小米TDS检测笔、bong智能体脂秤等",'全网通','4G+64G','热力红','12','OPPO R11','OPPO','5.5英寸','Android');
INSERT INTO sc_phone VALUES(NULL,3,'OPPO R11 6GB+128GB 全网通 4G手机 双卡双待手机  红色','OPPO R11 5.5英寸屏幕，6GB+128GB内存，前后2000万双摄像头，骁龙处理器！R11Plus热销中！','3499.00',"满1399元另加2元，即可在购物车换购bong2s手环、小米TDS检测笔、bong智能体脂秤等",'全网通','6G+128G','热力红','12','OPPO R11','OPPO','5.5英寸','Android');

INSERT INTO sc_phone VALUES(NULL,3,'OPPO R11 4GB+64GB 4G手机 全网通 双卡双待手机 玫瑰金','OPPO R11 5.5英寸屏幕，4GB+64GB内存，前后2000万双摄像头，骁龙处理器！R11Plus热销中！','2799.00',"满1399元另加2元，即可在购物车换购bong2s手环、小米TDS检测笔、bong智能体脂秤等",'全网通','4G+64G','玫瑰金','13','OPPO R11','OPPO','5.5英寸','Android');
INSERT INTO sc_phone VALUES(NULL,3,'OPPO R11 6GB+128GB 全网通 4G手机 双卡双待手机  玫瑰金','OPPO R11 5.5英寸屏幕，6GB+128GB内存，前后2000万双摄像头，骁龙处理器！R11Plus热销中！','3499.00',"满1399元另加2元，即可在购物车换购bong2s手环、小米TDS检测笔、bong智能体脂秤等",'全网通','6G+128G','玫瑰金','13','OPPO R11','OPPO','5.5英寸','Android');

#小米note3
INSERT INTO sc_phone VALUES(NULL,4,'小米Note3 全网通版 6GB+64GB 亮黑 移动联通电信4G手机 双卡双待','四曲面玻璃机身！前置1600万像素AI美颜！后置双摄拍人更美！高通8核处理器','2499.00',"满1399元另加2元，即可在购物车换购bong2s手环、小米TDS检测笔、bong智能体脂秤等",'全网通版','6GB+64G','亮黑','14','小米Note 3','小米','5.5英寸','Android');
INSERT INTO sc_phone VALUES(NULL,4,'小米Note3 全网通版 8GB+128GB 亮黑 移动联通电信4G手机 双卡双待','四曲面玻璃机身！前置1600万像素AI美颜！后置双摄拍人更美！高通8核处理器','2499.00',"满1399元另加2元，即可在购物车换购bong2s手环、小米TDS检测笔、bong智能体脂秤等",'全网通版','8GB+128G','亮黑','14','小米Note 3','小米','5.5英寸','Android');

INSERT INTO sc_phone VALUES(NULL,4,'小米Note3 全网通版 6GB+64GB 亮蓝 移动联通电信4G手机 双卡双待','四曲面玻璃机身！前置1600万像素AI美颜！后置双摄拍人更美！高通8核处理器','2499.00',"满1399元另加2元，即可在购物车换购bong2s手环、小米TDS检测笔、bong智能体脂秤等",'全网通版','6GB+64G','亮蓝','15','小米Note 3','小米','5.5英寸','Android');
INSERT INTO sc_phone VALUES(NULL,4,'小米Note3 全网通版 8GB+128GB 亮蓝 移动联通电信4G手机 双卡双待','四曲面玻璃机身！前置1600万像素AI美颜！后置双摄拍人更美！高通8核处理器','2499.00',"满1399元另加2元，即可在购物车换购bong2s手环、小米TDS检测笔、bong智能体脂秤等",'全网通版','8GB+128G','亮蓝','15','小米Note 3','小米','5.5英寸','Android');

#Apple
INSERT INTO sc_phone VALUES(NULL,5,'Apple iPhone X 64G 深空灰 移动联通电信 4G手机','【iPhone新品预约】iPhone X 全面屏，科技全面绽放 “hello，未来”5.8 英寸显示屏、A11 仿生、支持无线充电','8388.00',"满5600元另加5元，即可在购物车换购bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机",'全网通','64G','深空灰','16','iPhone X','Apple','5.8英寸','IOS');
INSERT INTO sc_phone VALUES(NULL,5,'Apple iPhone X 64G 深空灰 移动联通电信 4G手机','【iPhone新品预约】iPhone X 全面屏，科技全面绽放 “hello，未来”5.8 英寸显示屏、A11 仿生、支持无线充电','8388.00',"满5600元另加5元，即可在购物车换购bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机",'全网通','258G','深空灰','16','iPhone X','Apple','5.8英寸','IOS');

INSERT INTO sc_phone VALUES(NULL,5,'Apple iPhone X 64G 银色 移动联通电信 4G手机','【iPhone新品预约】iPhone X 全面屏，科技全面绽放 “hello，未来”5.8 英寸显示屏、A11 仿生、支持无线充电','8388.00',"满5600元另加5元，即可在购物车换购bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机",'全网通','64G','银色','17','iPhone X','Apple','5.8英寸','IOS');
INSERT INTO sc_phone VALUES(NULL,5,'Apple iPhone X 64G 银色 移动联通电信 4G手机','【iPhone新品预约】iPhone X 全面屏，科技全面绽放 “hello，未来”5.8 英寸显示屏、A11 仿生、支持无线充电','8388.00',"满5600元另加5元，即可在购物车换购bong智能手环+bong智能体脂秤+捷波朗蓝牙耳机",'全网通','258G','银色','17','iPhone X','Apple','5.8英寸','IOS');

#vivo
INSERT INTO sc_phone VALUES(NULL,6,'vivo X20 4GB+64GB 移动联通电信4G手机 双卡双待 磨砂黑','【12期免息，购机送豪礼】vivo X20 带你开启全面屏时代！逆光也清晰，照亮你的美！','2998.00',"满2400元另加1.1元，即可在购物车换购bong智能手环或体脂秤",'全网通','64G','磨砂黑','18','vivo X20','VIVO','6.0英寸','Android');
INSERT INTO sc_phone VALUES(NULL,6,'vivo X20 4GB+128GB 移动联通电信4G手机 双卡双待 磨砂黑','【12期免息，购机送豪礼】vivo X20 带你开启全面屏时代！逆光也清晰，照亮你的美！','3398.00',"满2400元另加1.1元，即可在购物车换购bong智能手环或体脂秤",'全网通','128G','磨砂黑','18','vivo X20','VIVO','6.0英寸','Android');

INSERT INTO sc_phone VALUES(NULL,6,'vivo X20 4GB+64GB 移动联通电信4G手机 双卡双待 玫瑰金','【12期免息，购机送豪礼】vivo X20 带你开启全面屏时代！逆光也清晰，照亮你的美！','2998.00',"满2400元另加1.1元，即可在购物车换购bong智能手环或体脂秤",'全网通','64G','玫瑰金','19','vivo X20','VIVO','6.0英寸','Android');
INSERT INTO sc_phone VALUES(NULL,6,'vivo X20 4GB+128GB 移动联通电信4G手机 双卡双待 玫瑰金','【12期免息，购机送豪礼】vivo X20 带你开启全面屏时代！逆光也清晰，照亮你的美！','3398.00',"满2400元另加1.1元，即可在购物车换购bong智能手环或体脂秤",'全网通','128G','玫瑰金','19','vivo X20','VIVO','6.0英寸','Android');

#honor
INSERT INTO sc_phone VALUES(NULL,7,'荣耀（honor）荣耀9 标配版 4GB+64GB 全网通版 海鸥灰','2000万变焦双摄/拍照就像用单反','2299.00',"满2400元另加1.1元，即可在购物车换购bong智能手环或体脂秤",'全网通','4GB+64GB','海鸥灰','20','荣耀9','荣耀','5.15英寸','Android');
INSERT INTO sc_phone VALUES(NULL,7,'荣耀（honor）荣耀9 高配版 6GB+64GB 全网通版 海鸥灰','2000万变焦双摄/拍照就像用单反','2699.00',"满2400元另加1.1元，即可在购物车换购bong智能手环或体脂秤",'全网通','6GB+64GB','海鸥灰','20','荣耀9','荣耀','5.15英寸','Android');
INSERT INTO sc_phone VALUES(NULL,7,'荣耀（honor）荣耀9 尊享版 6GB+128GB 全网通版 海鸥灰','2000万变焦双摄/拍照就像用单反','2999.00',"满2400元另加1.1元，即可在购物车换购bong智能手环或体脂秤",'全网通','6GB+128GB','海鸥灰','20','荣耀9','荣耀','5.15英寸','Android');

INSERT INTO sc_phone VALUES(NULL,7,'荣耀（honor）荣耀9 标配版 4GB+64GB 全网通版 琥珀金','2000万变焦双摄/拍照就像用单反','2299.00',"满2400元另加1.1元，即可在购物车换购bong智能手环或体脂秤",'全网通','4GB+64GB','琥珀金','21','荣耀9','荣耀','5.15英寸','Android');
INSERT INTO sc_phone VALUES(NULL,7,'荣耀（honor）荣耀9 高配版 6GB+64GB 全网通版 琥珀金','2000万变焦双摄/拍照就像用单反','2699.00',"满2400元另加1.1元，即可在购物车换购bong智能手环或体脂秤",'全网通','6GB+64GB','琥珀金','21','荣耀9','荣耀','5.15英寸','Android');
INSERT INTO sc_phone VALUES(NULL,7,'荣耀（honor）荣耀9 尊享版 6GB+128GB 全网通版 琥珀金','2000万变焦双摄/拍照就像用单反','2999.00',"满2400元另加1.1元，即可在购物车换购bong智能手环或体脂秤",'全网通','6GB+128GB','琥珀金','21','荣耀9','荣耀','5.15英寸','Android');

#华为nov 2
INSERT INTO sc_phone VALUES(NULL,8,'华为 HUAWEI nova2 Plus 4GB+128GB版 全网通版 双卡双待 草木绿','高颜值，爱自拍！前置2000万高清美拍，光学变焦双镜头','2599.00',"满2400元另加1.1元，即可在购物车换购bong智能手环或体脂秤",'全网通','6GB+128GB','草木绿','22','HUAWEI nova2','华为','5.5英寸','Android');
INSERT INTO sc_phone VALUES(NULL,8,'华为 HUAWEI nova2 Plus 4GB+64GB版 全网通版 双卡双待 草木绿','高颜值，爱自拍！前置2000万高清美拍，光学变焦双镜头','2599.00',"满2400元另加1.1元，即可在购物车换购bong智能手环或体脂秤",'全网通','6GB+64GB','草木绿','22','HUAWEI nova2','华为','5.5英寸','Android');

#华为mate9
INSERT INTO sc_phone VALUES(NULL,9,'华为 HUAWEI Mate9 Pro（LON-AL00）4GB+64GB 琥珀金','麒麟960芯片，第二代徕卡双摄镜头，2倍双摄变焦，4000mAh大电池','4399.00',"购买1件可得赠品，多买多赠，赠完即止，请在购物车点击领取",'全网通','4GB+64GB','琥珀金','23','HUAWEI Mate9 Pro','华为','5.5英寸','Android');
INSERT INTO sc_phone VALUES(NULL,9,'华为 HUAWEI Mate9 Pro（LON-AL00）6GB+128GB 琥珀金','麒麟960芯片，第二代徕卡双摄镜头，2倍双摄变焦，4000mAh大电池','4899.00',"购买1件可得赠品，多买多赠，赠完即止，请在购物车点击领取",'全网通','6GB+128GB','琥珀金','23','HUAWEI Mate9 Pro','华为','5.5英寸','Android');

##HUAWEI P10 Plus
INSERT INTO sc_phone VALUES(NULL,10,'HUAWEI P10 Plus 6GB+64GB版 全网通版 双卡双待 钻雕蓝','“人像摄影大师”徕卡SUMMILUX双镜头 一体化前置指纹 5.5英寸显示屏 麒麟960芯片','3988.00',"购买1件可得赠品，多买多赠，赠完即止，请在购物车点击领取",'全网通','6GB+64GB','钻雕蓝','24','HUAWEI P10 Plus','华为','5.5英寸','Android');
INSERT INTO sc_phone VALUES(NULL,10,'HUAWEI P10 Plus 6GB+128GB版 全网通版 双卡双待 钻雕蓝','“人像摄影大师”徕卡SUMMILUX双镜头 一体化前置指纹 5.5英寸显示屏 麒麟960芯片','4488.00',"购买1件可得赠品，多买多赠，赠完即止，请在购物车点击领取",'全网通','6GB+128GB','钻雕蓝','24','HUAWEI P10 Plus','华为','5.5英寸','Android');
INSERT INTO sc_phone VALUES(NULL,10,'HUAWEI P10 Plus 6GB+256GB版 全网通版 双卡双待 钻雕蓝','“人像摄影大师”徕卡SUMMILUX双镜头 一体化前置指纹 5.5英寸显示屏 麒麟960芯片','5588.00',"购买1件可得赠品，多买多赠，赠完即止，请在购物车点击领取",'全网通','6GB+256GB','钻雕蓝','24','HUAWEI P10 Plus','华为','5.5英寸','Android');


#畅想7
INSERT INTO sc_phone VALUES(NULL,11,'华为畅享7 (SLA-AL00) 2GB+16GB 全网通 双卡双待 红色','金属机身，骁龙芯片！','899.00',"购买1件可得赠品，多买多赠，赠完即止，请在购物车点击领取",'全网通','2GB+16GB','红色','25','华为畅享7','华为','5.0英寸','Android');
INSERT INTO sc_phone VALUES(NULL,11,'华为畅享7 (SLA-AL00) 3GB+32GB 全网通 双卡双待 红色','金属机身，骁龙芯片！','1099.00',"购买1件可得赠品，多买多赠，赠完即止，请在购物车点击领取",'全网通','3GB+32GB','红色','25','华为畅享7','华为','5.0英寸','Android');

#麦芒5
INSERT INTO sc_phone VALUES(NULL,12,'华为 HUAWEI 麦芒5 3GB+32GB 移动联通电信4G手机（玫瑰金）','特送：蓝牙耳机（HM1200）+50元移动充值卡+钢化膜+保护壳','2399.00',"购买1件可得赠品，多买多赠，赠完即止，请在购物车点击领取",'全网通','3GB+32GB','玫瑰金','26','HUAWEI 麦芒5','华为','5.5英寸','Android');
INSERT INTO sc_phone VALUES(NULL,12,'华为 HUAWEI 麦芒5 4GB+64GB 移动联通电信4G手机（玫瑰金）','特送：蓝牙耳机（HM1200）+50元移动充值卡+钢化膜+保护壳','2399.00',"购买1件可得赠品，多买多赠，赠完即止，请在购物车点击领取",'全网通','4GB+64GB','玫瑰金','26','HUAWEI 麦芒5','华为','5.5英寸','Android');

#N8
INSERT INTO sc_phone VALUES(NULL,13,'三星(SAMSUNG) Galaxy N8 (N9500) 全网通 手机 谜夜黑 6G+64G','三星Note8！全视曲面屏！后置双摄镜头双OIS光学防抖！无与伦"笔"！大有可为！','6988.00',"满6900元加3元得JBL耳机和JBL蓝牙音箱",'全网通','6GB+64GB','谜夜黑','27','Galaxy N8','SAMSUNG','6.3英寸','Android');
INSERT INTO sc_phone VALUES(NULL,13,'三星(SAMSUNG) Galaxy N8 (N9500) 全网通 手机 谜夜黑 6G+128G','三星Note8！全视曲面屏！后置双摄镜头双OIS光学防抖！无与伦"笔"！大有可为！','7388.00',"满6900元加3元得JBL耳机和JBL蓝牙音箱",'全网通','6GB+128GB','谜夜黑','27','Galaxy N8','SAMSUNG','6.3英寸','Android');
INSERT INTO sc_phone VALUES(NULL,13,'三星(SAMSUNG) Galaxy N8 (N9500) 全网通 手机 谜夜黑 6G+256G','三星Note8！全视曲面屏！后置双摄镜头双OIS光学防抖！无与伦"笔"！大有可为！','7988.00',"满6900元加3元得JBL耳机和JBL蓝牙音箱",'全网通','6GB+256GB','谜夜黑','27','Galaxy N8','SAMSUNG','6.3英寸','Android');

#C8
INSERT INTO sc_phone VALUES(NULL,14,'三星(SAMSUNG)GalaxyC8(C7100)全网通手机蔷薇粉4G+32G','后置双摄像头，面部识别！','2299.00',"满49元另加9.90元，即可在购物车换购西班牙原装进口红酒",'全网通','4GB+32GB','蔷薇粉','28','Galaxy C8','SAMSUNG','5.5英寸','Android');
INSERT INTO sc_phone VALUES(NULL,14,'三星(SAMSUNG)GalaxyC8(C7100)全网通手机蔷薇粉4G+64G','后置双摄像头，面部识别！','2399.00',"满49元另加9.90元，即可在购物车换购西班牙原装进口红酒",'全网通','4GB+64GB','蔷薇粉','28','Galaxy C8','SAMSUNG','5.5英寸','Android');

# C7 Pro
INSERT INTO sc_phone VALUES(NULL,15,'三星（SAMSUNG） Galaxy C7 Pro（C7010）4GB+64GB 苍海蓝 全网通4G手机','前后1600万像素，亮颜，美颜等自拍功能！息屏提醒，实时耳返，立体声效！','2699.00',"满49元另加9.90元，即可在购物车换购西班牙原装进口红酒",'全网通','4GB+64GB','苍海蓝','29','Galaxy C7 Pro','SAMSUNG','5.7英寸','Android');

#j30
INSERT INTO sc_phone VALUES(NULL,16,'三星(SAMSUNG) Galaxy J3 J3300 2017 凝霜蓝 移动联通电信 4G 手机 双卡双待','2017版J3，升级大内存，独立3卡槽，后置1300万像素！指纹识别、NFC功能！','1399.00',"满49元另加9.90元，即可在购物车换购西班牙原装进口红酒",'全网通','3GB+32GB','凝霜蓝','30','Galaxy J3','SAMSUNG','5.0英寸','Android');

#C9
INSERT INTO sc_phone VALUES(NULL,17,'三星（SAMSUNG） Galaxy C9 Pro（C9000）64G 枫叶金 全网通 4G手机 双卡双待','【加9.90元，即可在换购原价699的小米净化器】S助手领取好礼！前后1600万像素！','3199.00',"满49元另加9.90元，即可在购物车换购西班牙原装进口红酒",'全网通','4GB+64GB','枫叶金','31','Galaxy C9 Pro','SAMSUNG','6.0英寸','Android');

#a59s
INSERT INTO sc_phone VALUES(NULL,18,'OPPO A59s 4GB+32GB 全网通 4G手机 双卡双待手机 金色','前置1600万像素自拍手机！R11Plus热销中！','1799.00',"满49元另加9.90元，即可在购物车换购西班牙原装进口红酒",'全网通','4GB+32GB','金色','32','OPPO A59s','OPPO','5.5英寸','Android');

#a77
INSERT INTO sc_phone VALUES(NULL,19,'OPPO A77 3GB+32GB 全网通 4G手机 双卡双待手机 黑色','OPPO手机A77，5.5英寸屏，3GB+32GB内存，双卡双待。','1599.00',"满49元另加9.90元，即可在购物车换购西班牙原装进口红酒",'全网通','3GB+32GB','黑色','33','OPPO A77','OPPO','5.5英寸','Android');
INSERT INTO sc_phone VALUES(NULL,19,'OPPO A77 4GB+64GB 全网通 4G手机 双卡双待手机 黑色','OPPO手机A77，5.5英寸屏，4GB+64GB内存，双卡双待。','2199.00',"满49元另加9.90元，即可在购物车换购西班牙原装进口红酒",'全网通','4GB+64GB','黑色','33','OPPO A77','OPPO','5.5英寸','Android');
#57
INSERT INTO sc_phone VALUES(NULL,20,'OPPO A57 3GB+32GB 全网通 4G手机 双卡双待手机 玫瑰金色','小巧轻盈，双卡双待，前置1600万像素自拍手机。R11Plus热销中！','1299.00',"满49元另加9.90元，即可在购物车换购西班牙原装进口红酒",'全网通','3GB+32GB','玫瑰金','34','OPPO A57','OPPO','5.2英寸','Android');
#r11plus
INSERT INTO sc_phone VALUES(NULL,21,'OPPO R11Plus 6GB+64GB 全网通 4G手机 双卡双待手机 玫瑰金','OPPO R11Plus 6.0英寸大屏，6GB+64GB内存，前后2000万双摄像头，骁龙处理器！','3499.00',"满1399元另加2元，即可在购物车换购bong2s手环、小米TDS检测笔、bong智能体脂秤等",'全网通','6GB+64GB','玫瑰金','35','OPPO R11Plus','OPPO','6.0英寸','Android');

#r11s
INSERT INTO sc_phone VALUES(NULL,22,'OPPO R11s 4GB+64GB 全网通 4G 手机 双卡双待 红色','0.08s面部识别、前后2000万升级摄像头、游戏加速！','3199.00',"满1399元另加2元，即可在购物车换购bong2s手环、小米TDS检测笔、bong智能体脂秤等",'全网通','4GB+64GB','红色','36','OPPO R11s','OPPO','6.01英寸','Android');



/**手机图片**/
#GalaxyS8 三星s8
INSERT INTO sc_phone_pic VALUES(NULL, 1, 'img/product/sm/GalaxyS8(G9500)1.jpg','img/product/md/GalaxyS8(G9500)1.jpg','img/product/lg/GalaxyS8(G9500)1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 1, 'img/product/sm/GalaxyS8(G9500)2.jpg','img/product/md/GalaxyS8(G9500)2.jpg','img/product/lg/GalaxyS8(G9500)2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 1, 'img/product/sm/GalaxyS8(G9500)3.jpg','img/product/md/GalaxyS8(G9500)3.jpg','img/product/lg/GalaxyS8(G9500)3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 1, 'img/product/sm/GalaxyS8(G9500)4.jpg','img/product/md/GalaxyS8(G9500)4.jpg','img/product/lg/GalaxyS8(G9500)4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 1, 'img/product/sm/GalaxyS8(G9500)5.jpg','img/product/md/GalaxyS8(G9500)5.jpg','img/product/lg/GalaxyS8(G9500)5.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 1, 'img/product/sm/GalaxyS8(G9500)6.jpg','img/product/md/GalaxyS8(G9500)6.jpg','img/product/lg/GalaxyS8(G9500)6.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 1, 'img/product/sm/GalaxyS8(G9500)7.jpg','img/product/md/GalaxyS8(G9500)7.jpg','img/product/lg/GalaxyS8(G9500)7.jpg');

INSERT INTO sc_phone_pic VALUES(NULL, 2, 'img/product/sm/GalaxyS8(G9500)black1.jpg','img/product/md/GalaxyS8(G9500)black1.jpg','img/product/lg/GalaxyS8(G9500)black1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 2, 'img/product/sm/GalaxyS8(G9500)black2.jpg','img/product/md/GalaxyS8(G9500)black2.jpg','img/product/lg/GalaxyS8(G9500)black2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 2, 'img/product/sm/GalaxyS8(G9500)black3.jpg','img/product/md/GalaxyS8(G9500)black3.jpg','img/product/lg/GalaxyS8(G9500)black3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 2, 'img/product/sm/GalaxyS8(G9500)black4.jpg','img/product/md/GalaxyS8(G9500)black4.jpg','img/product/lg/GalaxyS8(G9500)black4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 2, 'img/product/sm/GalaxyS8(G9500)black5.jpg','img/product/md/GalaxyS8(G9500)black5.jpg','img/product/lg/GalaxyS8(G9500)black5.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 2, 'img/product/sm/GalaxyS8(G9500)black6.jpg','img/product/md/GalaxyS8(G9500)black6.jpg','img/product/lg/GalaxyS8(G9500)black6.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 2, 'img/product/sm/GalaxyS8(G9500)black7.jpg','img/product/md/GalaxyS8(G9500)black7.jpg','img/product/lg/GalaxyS8(G9500)black7.jpg');

INSERT INTO sc_phone_pic VALUES(NULL, 3, 'img/product/sm/GalaxyS8(G9500)gray1.jpg','img/product/md/GalaxyS8(G9500)gray1.jpg','img/product/lg/GalaxyS8(G9500)gray1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 3, 'img/product/sm/GalaxyS8(G9500)gray2.jpg','img/product/md/GalaxyS8(G9500)gray2.jpg','img/product/lg/GalaxyS8(G9500)gray2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 3, 'img/product/sm/GalaxyS8(G9500)gray3.jpg','img/product/md/GalaxyS8(G9500)gray3.jpg','img/product/lg/GalaxyS8(G9500)gray3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 3, 'img/product/sm/GalaxyS8(G9500)gray4.jpg','img/product/md/GalaxyS8(G9500)gray4.jpg','img/product/lg/GalaxyS8(G9500)gray4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 3, 'img/product/sm/GalaxyS8(G9500)gray5.jpg','img/product/md/GalaxyS8(G9500)gray5.jpg','img/product/lg/GalaxyS8(G9500)gray5.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 3, 'img/product/sm/GalaxyS8(G9500)gray6.jpg','img/product/md/GalaxyS8(G9500)gray6.jpg','img/product/lg/GalaxyS8(G9500)gray6.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 3, 'img/product/sm/GalaxyS8(G9500)gray7.jpg','img/product/md/GalaxyS8(G9500)gray7.jpg','img/product/lg/GalaxyS8(G9500)gray7.jpg');

INSERT INTO sc_phone_pic VALUES(NULL, 4, 'img/product/sm/GalaxyS8(G9500)gold1.jpg','img/product/md/GalaxyS8(G9500)gold1.jpg','img/product/lg/GalaxyS8(G9500)gold1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 4, 'img/product/sm/GalaxyS8(G9500)gold2.jpg','img/product/md/GalaxyS8(G9500)gold2.jpg','img/product/lg/GalaxyS8(G9500)gold2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 4, 'img/product/sm/GalaxyS8(G9500)gold3.jpg','img/product/md/GalaxyS8(G9500)gold3.jpg','img/product/lg/GalaxyS8(G9500)gold3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 4, 'img/product/sm/GalaxyS8(G9500)gold4.jpg','img/product/md/GalaxyS8(G9500)gold4.jpg','img/product/lg/GalaxyS8(G9500)gold4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 4, 'img/product/sm/GalaxyS8(G9500)gold5.jpg','img/product/md/GalaxyS8(G9500)gold5.jpg','img/product/lg/GalaxyS8(G9500)gold5.jpg');

INSERT INTO sc_phone_pic VALUES(NULL, 5, 'img/product/sm/GalaxyS8(G9500)pink1.jpg','img/product/md/GalaxyS8(G9500)pink1.jpg','img/product/lg/GalaxyS8(G9500)pink1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 5, 'img/product/sm/GalaxyS8(G9500)pink2.jpg','img/product/md/GalaxyS8(G9500)pink2.jpg','img/product/lg/GalaxyS8(G9500)pink2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 5, 'img/product/sm/GalaxyS8(G9500)pink3.jpg','img/product/md/GalaxyS8(G9500)pink3.jpg','img/product/lg/GalaxyS8(G9500)pink3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 5, 'img/product/sm/GalaxyS8(G9500)pink4.jpg','img/product/md/GalaxyS8(G9500)pink4.jpg','img/product/lg/GalaxyS8(G9500)pink4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 5, 'img/product/sm/GalaxyS8(G9500)pink5.jpg','img/product/md/GalaxyS8(G9500)pink5.jpg','img/product/lg/GalaxyS8(G9500)pink5.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 5, 'img/product/sm/GalaxyS8(G9500)pink6.jpg','img/product/md/GalaxyS8(G9500)pink6.jpg','img/product/lg/GalaxyS8(G9500)pink6.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 5, 'img/product/sm/GalaxyS8(G9500)pink7.jpg','img/product/md/GalaxyS8(G9500)pink7.jpg','img/product/lg/GalaxyS8(G9500)pink7.jpg');

#华为mate10

#黑色6
INSERT INTO sc_phone_pic VALUES(NULL, 6, 'img/product/sm/HUAWEIMate10(ALP-AL00)black1.jpg','img/product/md/HUAWEIMate10(ALP-AL00)black1.jpg','img/product/lg/HUAWEIMate10(ALP-AL00)black1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 6, 'img/product/sm/HUAWEIMate10(ALP-AL00)black2.jpg','img/product/md/HUAWEIMate10(ALP-AL00)black2.jpg','img/product/lg/HUAWEIMate10(ALP-AL00)black2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 6, 'img/product/sm/HUAWEIMate10(ALP-AL00)black3.jpg','img/product/md/HUAWEIMate10(ALP-AL00)black3.jpg','img/product/lg/HUAWEIMate10(ALP-AL00)black3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 6, 'img/product/sm/HUAWEIMate10(ALP-AL00)black4.jpg','img/product/md/HUAWEIMate10(ALP-AL00)black4.jpg','img/product/lg/HUAWEIMate10(ALP-AL00)black4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 6, 'img/product/sm/HUAWEIMate10(ALP-AL00)black5.jpg','img/product/md/HUAWEIMate10(ALP-AL00)black5.jpg','img/product/lg/HUAWEIMate10(ALP-AL00)black5.jpg');
#摩卡金7
INSERT INTO sc_phone_pic VALUES(NULL, 7, 'img/product/sm/HUAWEIMate10(ALP-AL00)gold1.jpg','img/product/md/HUAWEIMate10(ALP-AL00)gold1.jpg','img/product/lg/HUAWEIMate10(ALP-AL00)gold1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 7, 'img/product/sm/HUAWEIMate10(ALP-AL00)gold2.jpg','img/product/md/HUAWEIMate10(ALP-AL00)gold2.jpg','img/product/lg/HUAWEIMate10(ALP-AL00)gold2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 7, 'img/product/sm/HUAWEIMate10(ALP-AL00)gold3.jpg','img/product/md/HUAWEIMate10(ALP-AL00)gold3.jpg','img/product/lg/HUAWEIMate10(ALP-AL00)gold3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 7, 'img/product/sm/HUAWEIMate10(ALP-AL00)gold4.jpg','img/product/md/HUAWEIMate10(ALP-AL00)gold4.jpg','img/product/lg/HUAWEIMate10(ALP-AL00)gold4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 7, 'img/product/sm/HUAWEIMate10(ALP-AL00)gold5.jpg','img/product/md/HUAWEIMate10(ALP-AL00)gold5.jpg','img/product/lg/HUAWEIMate10(ALP-AL00)gold5.jpg');
#樱粉金8
INSERT INTO sc_phone_pic VALUES(NULL, 8, 'img/product/sm/HUAWEIMate10(ALP-AL00)pink1.jpg','img/product/md/HUAWEIMate10(ALP-AL00)pink1.jpg','img/product/lg/HUAWEIMate10(ALP-AL00)pink1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 8, 'img/product/sm/HUAWEIMate10(ALP-AL00)pink2.jpg','img/product/md/HUAWEIMate10(ALP-AL00)pink2.jpg','img/product/lg/HUAWEIMate10(ALP-AL00)pink2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 8, 'img/product/sm/HUAWEIMate10(ALP-AL00)pink3.jpg','img/product/md/HUAWEIMate10(ALP-AL00)pink3.jpg','img/product/lg/HUAWEIMate10(ALP-AL00)pink3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 8, 'img/product/sm/HUAWEIMate10(ALP-AL00)pink4.jpg','img/product/md/HUAWEIMate10(ALP-AL00)pink4.jpg','img/product/lg/HUAWEIMate10(ALP-AL00)pink4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 8, 'img/product/sm/HUAWEIMate10(ALP-AL00)pink5.jpg','img/product/md/HUAWEIMate10(ALP-AL00)pink5.jpg','img/product/lg/HUAWEIMate10(ALP-AL00)pink5.jpg');
#香槟金9
INSERT INTO sc_phone_pic VALUES(NULL, 9, 'img/product/sm/HUAWEIMate10(ALP-AL00)xgold1.jpg','img/product/md/HUAWEIMate10(ALP-AL00)xgold1.jpg','img/product/lg/HUAWEIMate10(ALP-AL00)xgold1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 9, 'img/product/sm/HUAWEIMate10(ALP-AL00)xgold2.jpg','img/product/md/HUAWEIMate10(ALP-AL00)xgold2.jpg','img/product/lg/HUAWEIMate10(ALP-AL00)xgold2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 9, 'img/product/sm/HUAWEIMate10(ALP-AL00)xgold3.jpg','img/product/md/HUAWEIMate10(ALP-AL00)xgold3.jpg','img/product/lg/HUAWEIMate10(ALP-AL00)xgold3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 9, 'img/product/sm/HUAWEIMate10(ALP-AL00)xgold4.jpg','img/product/md/HUAWEIMate10(ALP-AL00)xgold4.jpg','img/product/lg/HUAWEIMate10(ALP-AL00)xgold4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 9, 'img/product/sm/HUAWEIMate10(ALP-AL00)xgold5.jpg','img/product/md/HUAWEIMate10(ALP-AL00)xgold5.jpg','img/product/lg/HUAWEIMate10(ALP-AL00)xgold5.jpg');

#OPPO R11
#黑色
INSERT INTO sc_phone_pic VALUES(NULL, 10, 'img/product/sm/OPPOR11black1.jpg','img/product/md/OPPOR11black1.jpg','img/product/lg/OPPOR11black1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 10, 'img/product/sm/OPPOR11black2.jpg','img/product/md/OPPOR11black2.jpg','img/product/lg/OPPOR11black2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 10, 'img/product/sm/OPPOR11black3.jpg','img/product/md/OPPOR11black3.jpg','img/product/lg/OPPOR11black3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 10, 'img/product/sm/OPPOR11black4.jpg','img/product/md/OPPOR11black4.jpg','img/product/lg/OPPOR11black4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 10, 'img/product/sm/OPPOR11black5.jpg','img/product/md/OPPOR11black5.jpg','img/product/lg/OPPOR11black5.jpg');
#金色
INSERT INTO sc_phone_pic VALUES(NULL, 11, 'img/product/sm/OPPOR11gold1.jpg','img/product/md/OPPOR11gold1.jpg','img/product/lg/OPPOR11gold1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 11, 'img/product/sm/OPPOR11gold2.jpg','img/product/md/OPPOR11gold2.jpg','img/product/lg/OPPOR11gold2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 11, 'img/product/sm/OPPOR11gold3.jpg','img/product/md/OPPOR11gold3.jpg','img/product/lg/OPPOR11gold3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 11, 'img/product/sm/OPPOR11gold4.jpg','img/product/md/OPPOR11gold4.jpg','img/product/lg/OPPOR11gold4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 11, 'img/product/sm/OPPOR11gold5.jpg','img/product/md/OPPOR11gold5.jpg','img/product/lg/OPPOR11gold5.jpg');

#红色
INSERT INTO sc_phone_pic VALUES(NULL, 12, 'img/product/sm/OPPOR11red1.jpg','img/product/md/OPPOR11red1.jpg','img/product/lg/OPPOR11red1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 12, 'img/product/sm/OPPOR11red2.jpg','img/product/md/OPPOR11red2.jpg','img/product/lg/OPPOR11red2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 12, 'img/product/sm/OPPOR11red3.jpg','img/product/md/OPPOR11red3.jpg','img/product/lg/OPPOR11red3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 12, 'img/product/sm/OPPOR11red4.jpg','img/product/md/OPPOR11red4.jpg','img/product/lg/OPPOR11red4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 12, 'img/product/sm/OPPOR11red5.jpg','img/product/md/OPPOR11red5.jpg','img/product/lg/OPPOR11red5.jpg');

#玫瑰金
INSERT INTO sc_phone_pic VALUES(NULL, 13, 'img/product/sm/OPPOR11rose1.jpg','img/product/md/OPPOR11rose1.jpg','img/product/lg/OPPOR11rose1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 13, 'img/product/sm/OPPOR11rose2.jpg','img/product/md/OPPOR11rose2.jpg','img/product/lg/OPPOR11rose2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 13, 'img/product/sm/OPPOR11rose3.jpg','img/product/md/OPPOR11rose3.jpg','img/product/lg/OPPOR11rose3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 13, 'img/product/sm/OPPOR11rose4.jpg','img/product/md/OPPOR11rose4.jpg','img/product/lg/OPPOR11rose4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 13, 'img/product/sm/OPPOR11rose5.jpg','img/product/md/OPPOR11rose5.jpg','img/product/lg/OPPOR11rose5.jpg');

#MI NOTE3
#黑色
INSERT INTO sc_phone_pic VALUES(NULL, 14, 'img/product/sm/MINote3black1.jpg','img/product/md/MINote3black1.jpg','img/product/lg/MINote3black1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 14, 'img/product/sm/MINote3black2.jpg','img/product/md/MINote3black2.jpg','img/product/lg/MINote3black2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 14, 'img/product/sm/MINote3black3.jpg','img/product/md/MINote3black3.jpg','img/product/lg/MINote3black3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 14, 'img/product/sm/MINote3black4.jpg','img/product/md/MINote3black4.jpg','img/product/lg/MINote3black4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 14, 'img/product/sm/MINote3black5.jpg','img/product/md/MINote3black5.jpg','img/product/lg/MINote3black5.jpg');

#蓝色
INSERT INTO sc_phone_pic VALUES(NULL, 15, 'img/product/sm/MINote3blue1.jpg','img/product/md/MINote3blue1.jpg','img/product/lg/MINote3blue1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 15, 'img/product/sm/MINote3blue2.jpg','img/product/md/MINote3blue2.jpg','img/product/lg/MINote3blue2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 15, 'img/product/sm/MINote3blue3.jpg','img/product/md/MINote3blue3.jpg','img/product/lg/MINote3blue3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 15, 'img/product/sm/MINote3blue4.jpg','img/product/md/MINote3blue4.jpg','img/product/lg/MINote3blue4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 15, 'img/product/sm/MINote3blue5.jpg','img/product/md/MINote3blue5.jpg','img/product/lg/MINote3blue5.jpg');


#Apple
#深空灰
INSERT INTO sc_phone_pic VALUES(NULL, 16, 'img/product/sm/AppleiPhonegray1.jpg','img/product/md/AppleiPhonegray1.jpg','img/product/lg/AppleiPhonegray1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 16, 'img/product/sm/AppleiPhonegray2.jpg','img/product/md/AppleiPhonegray2.jpg','img/product/lg/AppleiPhonegray2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 16, 'img/product/sm/AppleiPhonegray3.jpg','img/product/md/AppleiPhonegray3.jpg','img/product/lg/AppleiPhonegray3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 16, 'img/product/sm/AppleiPhonegray4.jpg','img/product/md/AppleiPhonegray4.jpg','img/product/lg/AppleiPhonegray4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 16, 'img/product/sm/AppleiPhonegray5.jpg','img/product/md/AppleiPhonegray5.jpg','img/product/lg/AppleiPhonegray5.jpg');
#银色
INSERT INTO sc_phone_pic VALUES(NULL, 17, 'img/product/sm/AppleiPhoneyin1.jpg','img/product/md/AppleiPhoneyin1.jpg','img/product/lg/AppleiPhoneyin1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 17, 'img/product/sm/AppleiPhoneyin2.jpg','img/product/md/AppleiPhoneyin2.jpg','img/product/lg/AppleiPhoneyin2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 17, 'img/product/sm/AppleiPhoneyin3.jpg','img/product/md/AppleiPhoneyin3.jpg','img/product/lg/AppleiPhoneyin3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 17, 'img/product/sm/AppleiPhoneyin4.jpg','img/product/md/AppleiPhoneyin4.jpg','img/product/lg/AppleiPhoneyin4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 17, 'img/product/sm/AppleiPhoneyin5.jpg','img/product/md/AppleiPhoneyin5.jpg','img/product/lg/AppleiPhoneyin5.jpg');

#vivo
#黑色
INSERT INTO sc_phone_pic VALUES(NULL, 18, 'img/product/sm/vivoX20Ablack1.jpg','img/product/md/vivoX20Ablack1.jpg','img/product/lg/vivoX20Ablack1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 18, 'img/product/sm/vivoX20Ablack2.jpg','img/product/md/vivoX20Ablack2.jpg','img/product/lg/vivoX20Ablack2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 18, 'img/product/sm/vivoX20Ablack3.jpg','img/product/md/vivoX20Ablack3.jpg','img/product/lg/vivoX20Ablack3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 18, 'img/product/sm/vivoX20Ablack4.jpg','img/product/md/vivoX20Ablack4.jpg','img/product/lg/vivoX20Ablack4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 18, 'img/product/sm/vivoX20Ablack5.jpg','img/product/md/vivoX20Ablack5.jpg','img/product/lg/vivoX20Ablack5.jpg');

#粉色
INSERT INTO sc_phone_pic VALUES(NULL, 19, 'img/product/sm/vivoX20Apink1.jpg','img/product/md/vivoX20Apink1.jpg','img/product/lg/vivoX20Apink1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 19, 'img/product/sm/vivoX20Apink2.jpg','img/product/md/vivoX20Apink2.jpg','img/product/lg/vivoX20Apink2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 19, 'img/product/sm/vivoX20Apink3.jpg','img/product/md/vivoX20Apink3.jpg','img/product/lg/vivoX20Apink3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 19, 'img/product/sm/vivoX20Apink4.jpg','img/product/md/vivoX20Apink4.jpg','img/product/lg/vivoX20Apink4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 19, 'img/product/sm/vivoX20Apink5.jpg','img/product/md/vivoX20Apink5.jpg','img/product/lg/vivoX20Apink5.jpg');


#Honor
#灰色
INSERT INTO sc_phone_pic VALUES(NULL, 20, 'img/product/sm/Honor(honor9)gray1.jpg','img/product/md/Honor(honor9)gray1.jpg','img/product/lg/Honor(honor9)gray1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 20, 'img/product/sm/Honor(honor9)gray2.jpg','img/product/md/Honor(honor9)gray2.jpg','img/product/lg/Honor(honor9)gray2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 20, 'img/product/sm/Honor(honor9)gray3.jpg','img/product/md/Honor(honor9)gray3.jpg','img/product/lg/Honor(honor9)gray3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 20, 'img/product/sm/Honor(honor9)gray4.jpg','img/product/md/Honor(honor9)gray4.jpg','img/product/lg/Honor(honor9)gray4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 20, 'img/product/sm/Honor(honor9)gray5.jpg','img/product/md/Honor(honor9)gray5.jpg','img/product/lg/Honor(honor9)gray5.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 20, 'img/product/sm/Honor(honor9)gray6.jpg','img/product/md/Honor(honor9)gray6.jpg','img/product/lg/Honor(honor9)gray6.jpg');
#金色
INSERT INTO sc_phone_pic VALUES(NULL, 21, 'img/product/sm/Honor(honor9)gold1.jpg','img/product/md/Honor(honor9)gold1.jpg','img/product/lg/Honor(honor9)gold1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 21, 'img/product/sm/Honor(honor9)gold2.jpg','img/product/md/Honor(honor9)gold2.jpg','img/product/lg/Honor(honor9)gold2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 21, 'img/product/sm/Honor(honor9)gold3.jpg','img/product/md/Honor(honor9)gold3.jpg','img/product/lg/Honor(honor9)gold3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 21, 'img/product/sm/Honor(honor9)gold4.jpg','img/product/md/Honor(honor9)gold4.jpg','img/product/lg/Honor(honor9)gold4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 21, 'img/product/sm/Honor(honor9)gold5.jpg','img/product/md/Honor(honor9)gold5.jpg','img/product/lg/Honor(honor9)gold5.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 21, 'img/product/sm/Honor(honor9)gold6.jpg','img/product/md/Honor(honor9)gold6.jpg','img/product/lg/Honor(honor9)gold6.jpg');


#华为nova2
INSERT INTO sc_phone_pic VALUES(NULL, 22, 'img/product/sm/HUAWEnova21.jpg','img/product/md/HUAWEnova21.jpg','img/product/lg/HUAWEnova21.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 22, 'img/product/sm/HUAWEnova22.jpg','img/product/md/HUAWEnova22.jpg','img/product/lg/HUAWEnova22.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 22, 'img/product/sm/HUAWEnova23.jpg','img/product/md/HUAWEnova23.jpg','img/product/lg/HUAWEnova23.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 22, 'img/product/sm/HUAWEnova24.jpg','img/product/md/HUAWEnova24.jpg','img/product/lg/HUAWEnova24.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 22, 'img/product/sm/HUAWEnova25.jpg','img/product/md/HUAWEnova25.jpg','img/product/lg/HUAWEnova25.jpg');


##华为mate10
INSERT INTO sc_phone_pic VALUES(NULL, 23, 'img/product/md/HUAWEIMate91.jpg','img/product/md/HUAWEIMate91.jpg','img/product/md/HUAWEIMate91.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 23, 'img/product/md/HUAWEIMate92.jpg','img/product/md/HUAWEIMate92.jpg','img/product/md/HUAWEIMate92.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 23, 'img/product/md/HUAWEIMate93.jpg','img/product/md/HUAWEIMate93.jpg','img/product/md/HUAWEIMate93.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 23, 'img/product/md/HUAWEIMate94.jpg','img/product/md/HUAWEIMate94.jpg','img/product/md/HUAWEIMate94.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 23, 'img/product/md/HUAWEIMate95.jpg','img/product/md/HUAWEIMate95.jpg','img/product/md/HUAWEIMate95.jpg');


##HUAWEI P10 Plus
INSERT INTO sc_phone_pic VALUES(NULL, 24, 'img/product/md/HUAWEIP101.jpg','img/product/md/HUAWEIP101.jpg','img/product/md/HUAWEIP101.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 24, 'img/product/md/HUAWEIP102.jpg','img/product/md/HUAWEIP102.jpg','img/product/md/HUAWEIP102.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 24, 'img/product/md/HUAWEIP103.jpg','img/product/md/HUAWEIP103.jpg','img/product/md/HUAWEIP103.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 24, 'img/product/md/HUAWEIP104.jpg','img/product/md/HUAWEIP104.jpg','img/product/md/HUAWEIP104.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 24, 'img/product/md/HUAWEIP105.jpg','img/product/md/HUAWEIP105.jpg','img/product/md/HUAWEIP105.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 24, 'img/product/md/HUAWEIP106.jpg','img/product/md/HUAWEIP106.jpg','img/product/md/HUAWEIP106.jpg');

#畅想7
INSERT INTO sc_phone_pic VALUES(NULL, 25, 'img/product/md/changxiang7(SLA-AL00)1.jpg','img/product/md/changxiang7(SLA-AL00)1.jpg','img/product/md/changxiang7(SLA-AL00)1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 25, 'img/product/md/changxiang7(SLA-AL00)2.jpg','img/product/md/changxiang7(SLA-AL00)2.jpg','img/product/md/changxiang7(SLA-AL00)2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 25, 'img/product/md/changxiang7(SLA-AL00)3.jpg','img/product/md/changxiang7(SLA-AL00)3.jpg','img/product/md/changxiang7(SLA-AL00)3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 25, 'img/product/md/changxiang7(SLA-AL00)4.jpg','img/product/md/changxiang7(SLA-AL00)4.jpg','img/product/md/changxiang7(SLA-AL00)4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 25, 'img/product/md/changxiang7(SLA-AL00)5.jpg','img/product/md/changxiang7(SLA-AL00)5.jpg','img/product/md/changxiang7(SLA-AL00)5.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 25, 'img/product/md/changxiang7(SLA-AL00)6.jpg','img/product/md/changxiang7(SLA-AL00)6.jpg','img/product/md/changxiang7(SLA-AL00)6.jpg');

#麦芒5
INSERT INTO sc_phone_pic VALUES(NULL, 26, 'img/product/md/HUAWEImaimang51.jpg','img/product/md/HUAWEImaimang51.jpg','img/product/md/HUAWEImaimang51.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 26, 'img/product/md/HUAWEImaimang52.jpg','img/product/md/HUAWEImaimang52.jpg','img/product/md/HUAWEImaimang52.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 26, 'img/product/md/HUAWEImaimang53.jpg','img/product/md/HUAWEImaimang53.jpg','img/product/md/HUAWEImaimang53.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 26, 'img/product/md/HUAWEImaimang54.jpg','img/product/md/HUAWEImaimang54.jpg','img/product/md/HUAWEImaimang54.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 26, 'img/product/md/HUAWEImaimang55.jpg','img/product/md/HUAWEImaimang55.jpg','img/product/md/HUAWEImaimang55.jpg');

##N8
INSERT INTO sc_phone_pic VALUES(NULL, 27, 'img/product/md/GalaxyN81.jpg','img/product/md/GalaxyN81.jpg','img/product/md/GalaxyN81.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 27, 'img/product/md/GalaxyN82.jpg','img/product/md/GalaxyN82.jpg','img/product/md/GalaxyN82.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 27, 'img/product/md/GalaxyN83.jpg','img/product/md/GalaxyN83.jpg','img/product/md/GalaxyN83.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 27, 'img/product/md/GalaxyN84.jpg','img/product/md/GalaxyN84.jpg','img/product/md/GalaxyN84.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 27, 'img/product/md/GalaxyN85.jpg','img/product/md/GalaxyN85.jpg','img/product/md/GalaxyN85.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 27, 'img/product/md/GalaxyN86.jpg','img/product/md/GalaxyN86.jpg','img/product/md/GalaxyN86.jpg');

#c8
INSERT INTO sc_phone_pic VALUES(NULL, 28, 'img/product/md/GalaxyC8(C7100)1.jpg','img/product/md/GalaxyC8(C7100)1.jpg','img/product/md/GalaxyC8(C7100)1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 28, 'img/product/md/GalaxyC8(C7100)2.jpg','img/product/md/GalaxyC8(C7100)2.jpg','img/product/md/GalaxyC8(C7100)2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 28, 'img/product/md/GalaxyC8(C7100)3.jpg','img/product/md/GalaxyC8(C7100)3.jpg','img/product/md/GalaxyC8(C7100)3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 28, 'img/product/md/GalaxyC8(C7100)4.jpg','img/product/md/GalaxyC8(C7100)4.jpg','img/product/md/GalaxyC8(C7100)4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 28, 'img/product/md/GalaxyC8(C7100)5.jpg','img/product/md/GalaxyC8(C7100)5.jpg','img/product/md/GalaxyC8(C7100)5.jpg');

#c7
INSERT INTO sc_phone_pic VALUES(NULL, 29, 'img/product/md/GalaxyC7Pro1.jpg','img/product/md/GalaxyC7Pro1.jpg','img/product/md/GalaxyC7Pro1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 29, 'img/product/md/GalaxyC7Pro2.jpg','img/product/md/GalaxyC7Pro2.jpg','img/product/md/GalaxyC7Pro2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 29, 'img/product/md/GalaxyC7Pro3.jpg','img/product/md/GalaxyC7Pro3.jpg','img/product/md/GalaxyC7Pro3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 29, 'img/product/md/GalaxyC7Pro4.jpg','img/product/md/GalaxyC7Pro4.jpg','img/product/md/GalaxyC7Pro4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 29, 'img/product/md/GalaxyC7Pro5.jpg','img/product/md/GalaxyC7Pro5.jpg','img/product/md/GalaxyC7Pro5.jpg');

#j3
INSERT INTO sc_phone_pic VALUES(NULL, 30, 'img/product/md/GalaxyJ30.jpg','img/product/md/GalaxyJ30.jpg','img/product/md/GalaxyJ30.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 30, 'img/product/md/GalaxyJ31.jpg','img/product/md/GalaxyJ31.jpg','img/product/md/GalaxyJ31.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 30, 'img/product/md/GalaxyJ32.jpg','img/product/md/GalaxyJ32.jpg','img/product/md/GalaxyJ32.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 30, 'img/product/md/GalaxyJ33.jpg','img/product/md/GalaxyJ33.jpg','img/product/md/GalaxyJ33.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 30, 'img/product/md/GalaxyJ34.jpg','img/product/md/GalaxyJ34.jpg','img/product/md/GalaxyJ34.jpg');

#C9
INSERT INTO sc_phone_pic VALUES(NULL, 31, 'img/product/md/GalaxyC9Pro(C9000)0.jpg','img/product/md/GalaxyC9Pro(C9000)0.jpg','img/product/md/GalaxyC9Pro(C9000)0.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 31, 'img/product/md/GalaxyC9Pro(C9000)1.jpg','img/product/md/GalaxyC9Pro(C9000)1.jpg','img/product/md/GalaxyC9Pro(C9000)1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 31, 'img/product/md/GalaxyC9Pro(C9000)2.jpg','img/product/md/GalaxyC9Pro(C9000)2.jpg','img/product/md/GalaxyC9Pro(C9000)2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 31, 'img/product/md/GalaxyC9Pro(C9000)3.jpg','img/product/md/GalaxyC9Pro(C9000)3.jpg','img/product/md/GalaxyC9Pro(C9000)3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 31, 'img/product/md/GalaxyC9Pro(C9000)4.jpg','img/product/md/GalaxyC9Pro(C9000)4.jpg','img/product/md/GalaxyC9Pro(C9000)4.jpg');


#a59s
INSERT INTO sc_phone_pic VALUES(NULL, 32, 'img/product/md/OPPOA59s1.jpg','img/product/md/OPPOA59s1.jpg','img/product/md/OPPOA59s1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 32, 'img/product/md/OPPOA59s2.jpg','img/product/md/OPPOA59s2.jpg','img/product/md/OPPOA59s2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 32, 'img/product/md/OPPOA59s3.jpg','img/product/md/OPPOA59s3.jpg','img/product/md/OPPOA59s3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 32, 'img/product/md/OPPOA59s4.jpg','img/product/md/OPPOA59s4.jpg','img/product/md/OPPOA59s4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 32, 'img/product/md/OPPOA59s5.jpg','img/product/md/OPPOA59s5.jpg','img/product/md/OPPOA59s5.jpg');

#a77
INSERT INTO sc_phone_pic VALUES(NULL, 33, 'img/product/md/OPPOA771.jpg','img/product/md/OPPOA771.jpg','img/product/md/OPPOA771.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 33, 'img/product/md/OPPOA772.jpg','img/product/md/OPPOA772.jpg','img/product/md/OPPOA772.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 33, 'img/product/md/OPPOA773.jpg','img/product/md/OPPOA773.jpg','img/product/md/OPPOA773.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 33, 'img/product/md/OPPOA774.jpg','img/product/md/OPPOA774.jpg','img/product/md/OPPOA774.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 33, 'img/product/md/OPPOA775.jpg','img/product/md/OPPOA775.jpg','img/product/md/OPPOA775.jpg');

#a57
INSERT INTO sc_phone_pic VALUES(NULL, 34, 'img/product/md/OPPOA571.jpg','img/product/md/OPPOA571.jpg','img/product/md/OPPOA571.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 34, 'img/product/md/OPPOA572.jpg','img/product/md/OPPOA572.jpg','img/product/md/OPPOA572.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 34, 'img/product/md/OPPOA573.jpg','img/product/md/OPPOA573.jpg','img/product/md/OPPOA574.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 34, 'img/product/md/OPPOA574.jpg','img/product/md/OPPOA574.jpg','img/product/md/OPPOA575.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 34, 'img/product/md/OPPOA575.jpg','img/product/md/OPPOA575.jpg','img/product/md/OPPOA576.jpg');

#r11plus
INSERT INTO sc_phone_pic VALUES(NULL, 35, 'img/product/md/OPPOR11Plus1.jpg','img/product/md/OPPOR11Plus1.jpg','img/product/md/OPPOR11Plus1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 35, 'img/product/md/OPPOR11Plus2.jpg','img/product/md/OPPOR11Plus2.jpg','img/product/md/OPPOR11Plus2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 35, 'img/product/md/OPPOR11Plus3.jpg','img/product/md/OPPOR11Plus3.jpg','img/product/md/OPPOR11Plus3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 35, 'img/product/md/OPPOR11Plus4.jpg','img/product/md/OPPOR11Plus4.jpg','img/product/md/OPPOR11Plus4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 35, 'img/product/md/OPPOR11Plus5.jpg','img/product/md/OPPOR11Plus5.jpg','img/product/md/OPPOR11Plus5.jpg');
#r11s
INSERT INTO sc_phone_pic VALUES(NULL, 36, 'img/product/md/oppoR11s1.jpg','img/product/md/oppoR11s1.jpg','img/product/md/oppoR11s1.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 36, 'img/product/md/oppoR11s2.jpg','img/product/md/oppoR11s2.jpg','img/product/md/oppoR11s2.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 36, 'img/product/md/oppoR11s3.jpg','img/product/md/oppoR11s3.jpg','img/product/md/oppoR11s3.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 36, 'img/product/md/oppoR11s4.jpg','img/product/md/oppoR11s4.jpg','img/product/md/oppoR11s4.jpg');
INSERT INTO sc_phone_pic VALUES(NULL, 36, 'img/product/md/oppoR11s5.jpg','img/product/md/oppoR11s5.jpg','img/product/md/oppoR11s5.jpg');




/**********************************************/
/****首页楼层商品****/

INSERT INTO sc_floor_product VALUES(NULL,"华为","6期免息送10豪礼，麒麟960芯片","img/index/huawei11.jpg","5888.00","product-details.html?lid=25","HUAWEI","1251","0",25);
INSERT INTO sc_floor_product VALUES(NULL,"HUAWEI Mate10","6期免息送10豪礼，麒麟960芯片","img/index/huaweiMate10.jpg","5888.00","product-details.html?lid=25","HUAWEI","1666","1",25);
INSERT INTO sc_floor_product VALUES(NULL,"HUAWEI nova2 Plus","前置2000万高清美拍，光学变焦双镜头","img/product/md/HUAWEnova21.jpg","2599.00","product-details.html?lid=55","HUAWEI","1128","2",55);
INSERT INTO sc_floor_product VALUES(NULL,"HUAWEI P10 Plus","“人像摄影大师”徕卡SUMMILUX双镜头","img/product/md/HUAWEIP101.jpg","3988.00","product-details.html?lid=59","HUAWEI","963","3",59);
INSERT INTO sc_floor_product VALUES(NULL,"华为 HUAWEI Mate9 Pro","麒麟960芯片，第二代徕卡双摄镜头","img/product/md/HUAWEIMate91.jpg","4899.00","product-details.html?lid=58","HUAWEI","1555","4",58);
INSERT INTO sc_floor_product VALUES(NULL,"华为畅享7 (SLA-AL00)","金属机身，骁龙芯片！","img/product/md/changxiang7(SLA-AL00)1.jpg","1099.00","product-details.html?lid=62","HUAWEI","989","5",62);
INSERT INTO sc_floor_product VALUES(NULL,"华为 HUAWEI 麦芒5","特送：蓝牙耳机（HM1200）","img/product/md/HUAWEImaimang51.jpg","2399.0","product-details.html?lid=64","HUAWEI","1888","6",64);

INSERT INTO sc_floor_product VALUES(NULL,"三星","6期免息送10豪礼，麒麟960芯片","img/index/SAMSUNG11.jpg","5888.00","product-details.html?lid=1","SAMSUNG","1351","0",1);
INSERT INTO sc_floor_product VALUES(NULL,"Galaxy S8","6期免息送10豪礼，麒麟960芯片","img/index/SAMSUNGnote8_.jpg","5888.00","product-details.html?lid=66","SAMSUNG","1991","1",66);
INSERT INTO sc_floor_product VALUES(NULL,"SAMSUNG Galaxy N8","全视曲面屏！后置双摄镜头双OIS光学防抖！","img/product/md/GalaxyN81.jpg","6988.00","product-details.html?lid=66","SAMSUNG","1251","2",66);
INSERT INTO sc_floor_product VALUES(NULL,"SAMSUNG Galaxy C8","5.5英寸，后置双摄像头，面部识别+指纹识别！","img/product/md/GalaxyC8(C7100)1.jpg","2399.00","product-details.html?lid=69","SAMSUNG","1200","3",69);
INSERT INTO sc_floor_product VALUES(NULL,"SAMSUNG Galaxy C7 Pro","前后1600万像素，亮颜，美颜等自拍功能！","img/product/md/GalaxyC7Pro1.jpg","2699.00","product-details.html?lid=71","SAMSUNG","1555","4",71);
INSERT INTO sc_floor_product VALUES(NULL,"SAMSUNG Galaxy J3","2017版J3，升级大内存，独立3卡槽，后置1300万像素！","img/product/md/GalaxyJ31.jpg","1399.00","product-details.html?lid=72","SAMSUNG","5899","5",72);
INSERT INTO sc_floor_product VALUES(NULL,"Galaxy C9 Pro","金属机身6GB+64GB大内存，前后1600万像素","img/product/md/GalaxyC9Pro(C9000)1.jpg","3199.00","product-details.html?lid=73","SAMSUNG","1089","6",73);

INSERT INTO sc_floor_product VALUES(NULL,"OPPO","6期免息送10豪礼，麒麟960芯片","img/index/OPPO11.jpg","5888.00","product-details.html?lid=1","OPPO","1251","0",1);
INSERT INTO sc_floor_product VALUES(NULL,"OPPO A77","6期免息送10豪礼，麒麟960芯片","img/index/OPPOA77.jpg","5888.00","product-details.html?lid=77","OPPO","3121","1",77);
INSERT INTO sc_floor_product VALUES(NULL,"OPPO R11","前后2000万双摄像头，骁龙处理器","img/product/md/OPPOR11red1.jpg","2999.00","product-details.html?lid=33","OPPO","2151","2",33);
INSERT INTO sc_floor_product VALUES(NULL,"OPPO A59s","前置1600万像素自拍手机！","img/product/md/OPPOA59s1.jpg","1599.00","product-details.html?lid=74","OPPO","1200","3",74);
INSERT INTO sc_floor_product VALUES(NULL,"OPPO A77","5.5英寸屏，3GB+32GB内存，双卡双待","img/product/md/OPPOA771.jpg","1699.00","product-details.html?lid=75","OPPO","1258","4",75);
INSERT INTO sc_floor_product VALUES(NULL,"OPPO A57","小巧轻盈，双卡双待，前置1600万像素自拍手机。","img/product/md/OPPOA571.jpg","1299.00","product-details.html?lid=77","OPPO","9999","5",77);
INSERT INTO sc_floor_product VALUES(NULL,"OPPO R11Plus","6.0英寸大屏，6GB+64GB内存","img/product/md/OPPOR11Plus1.jpg","3499.00","product-details.html?lid=78","OPPO","6688","6",78);


/**详情页推荐**/
INSERT INTO sc_recommend_product VALUES(null,'OPPO R11 6GB+128GB 全网通 4G手机 双卡双待手机 红色','img/product/md/OPPOR11red1.jpg','product-details.html?lid=34');
INSERT INTO sc_recommend_product VALUES(null,'华为手机Mate10(ALP-AL00) 6GB+128GB 全网通 双卡双待 亮黑','img/product/md/HUAWEIMate10(ALP-AL00)black1.jpg','product-details.html?lid=21');
INSERT INTO sc_recommend_product VALUES(null,'三星(SAMSUNG) Galaxy S8(G9500) 全网通 手机 谜夜黑 4G手机','img/product/md/GalaxyS8(G9500)black1.jpg','product-details.html?lid=2');
INSERT INTO sc_recommend_product VALUES(null,'vivo X20A 4GB+64GB 移动联通电信4G手机 双卡双待 玫瑰金','img/product/md/vivoX20Apink1.jpg','product-details.html?lid=47');
INSERT INTO sc_recommend_product VALUES(null,'MI手机小米Note3全网通版6GB+64GB亮黑移动联通电信4G手机双卡双待','img/product/md/MINote3black1.jpg','product-details.html?lid=37');
INSERT INTO sc_recommend_product VALUES(null,'荣耀（honor）荣耀9 高配版 6GB+64GB 全网通版 海鸥灰','img/product/md/Honor(honor9)gray1.jpg','product-details.html?lid=50');
INSERT INTO sc_recommend_product VALUES(null,'Apple iPhone X 64G 深空灰 移动联通电信4G手机','img/product/md/AppleiPhonegray1.jpg','product-details.html?lid=41');




/**用户信息**/
INSERT INTO sc_user VALUES
(NULL, 'dingding', '123456', 'ding@qq.com', '13501234567', 'img/avatar/default.png', '丁伟', '1'),
(NULL, 'dangdang', '123456', 'dang@qq.com', '13501234568', 'img/avatar/default.png', '林当', '1'),
(NULL, 'doudou', '123456', 'dou@qq.com', '13501234569', 'img/avatar/default.png', '窦志强', '1'),
(NULL, 'yaya', '123456', 'ya@qq.com', '13501234560', 'img/avatar/default.png', '秦小雅', '0');


/*用户地址*/
