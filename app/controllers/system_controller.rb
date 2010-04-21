class SystemController < ApplicationController
  def index
  end
  
  def init_system
    #  初始化部门信息
    Department.delete_all
    zgyz=Department.create(:name=>"中国邮政集团公司", :address=>"北京市西城区宣武门西大街131号")
    qh=Department.create(:name=>"青海省邮政公司", :parent_id=>zgyz.id, :address=>"西宁市五四西路36号")

    Department.create(:name=>"西宁市邮政局", :parent_id=>qh.id, :address=>"西宁市冷湖路北段7号")
    Department.create(:name=>"青海省邮政信息技术局", :parent_id=>qh.id, :address=>"西宁市五四西路36号")
    Department.create(:name=>"青海省邮政商函公司", :parent_id=>qh.id, :address=>"西宁市五四西路36号")
    Department.create(:name=>"青海省邮票公司", :parent_id=>qh.id, :address=>"西宁市五四西路36号")
    Department.create(:name=>"青海省邮政运输局", :parent_id=>qh.id, :address=>"西宁市冷互助中路")
    Department.create(:name=>"青海省速递物流公司", :parent_id=>qh.id, :address=>"西宁市长江路93号")
    Department.create(:name=>"青海省邮政电子商务局", :parent_id=>qh.id, :address=>"西宁市五四西路36号")

    xn=Department.create(:name=>"西宁市邮政局", :parent_id=>qh.id, :address=>"西宁市冷湖路北段7号")
    Department.create(:name=>"城东区邮政局", :parent_id=>xn.id, :address=>"西宁市互助路")
    Department.create(:name=>"城西区邮政局", :parent_id=>xn.id, :address=>"西宁市新宁路")
    Department.create(:name=>"城南区邮政局", :parent_id=>xn.id, :address=>"西宁市新青路")
    Department.create(:name=>"城中区邮政局", :parent_id=>xn.id, :address=>"西宁市西大街1号")
    Department.create(:name=>"城北区邮政局", :parent_id=>xn.id, :address=>"西宁市小桥大街")
    Department.create(:name=>"大通县邮政局", :parent_id=>xn.id, :address=>"西宁市小桥大街")
    Department.create(:name=>"湟中县邮政局", :parent_id=>xn.id, :address=>"西宁市小桥大街")
    Department.create(:name=>"湟源县邮政局", :parent_id=>xn.id, :address=>"西宁市小桥大街")


    hd=Department.create(:name=>"海东地区邮政局", :parent_id=>qh.id, :address=>"平安县")
    Department.create(:name=>"互助县邮政局", :parent_id=>hd.id, :address=>"互助县")
    Department.create(:name=>"化隆县邮政局", :parent_id=>hd.id, :address=>"化隆县")
    Department.create(:name=>"循化县邮政局", :parent_id=>hd.id, :address=>"循化县")
    Department.create(:name=>"乐都县邮政局", :parent_id=>hd.id, :address=>"乐都县")
    Department.create(:name=>"民和县邮政局", :parent_id=>hd.id, :address=>"民和县")

    hx=Department.create(:name=>"海西州邮政局", :parent_id=>qh.id, :address=>"德令哈市")

    hn=Department.create(:name=>"海南州邮政局", :parent_id=>qh.id, :address=>"共和县")

    hb=Department.create(:name=>"海北州邮政局", :parent_id=>qh.id, :address=>"海晏县")

    hn=Department.create(:name=>"黄南州邮政局", :parent_id=>qh.id, :address=>"同仁县")

    gl=Department.create(:name=>"果洛州邮政局", :parent_id=>qh.id, :address=>"玛沁县")

    ys=Department.create(:name=>"玉树州邮政局", :parent_id=>qh.id, :address=>"玉树县")

    gem=Department.create(:name=>"格尔木市邮政局", :parent_id=>qh.id, :address=>"格尔木市迎宾路1号")

    #    初始化设备类型信息
    DeviceType.delete_all
    computer=DeviceType.create(:name=>"计算机设备",:table=>"computer")
    network=DeviceType.create(:name=>"网络设备",:table=>"network")
    asscessory=DeviceType.create(:name=>"附属设备",:table=>"accessory")
    support=DeviceType.create(:name=>"配套设备",:table=>"support_equipment")
    other=DeviceType.create(:name=>"其他设备",:table=>"other")

    DeviceType.create(:name=>"小型机",:table=>"computer_detail",:parent_id=>computer.id)
    DeviceType.create(:name=>"服务器",:table=>"computer_detail",:parent_id=>computer.id)
    DeviceType.create(:name=>"pc机",:table=>"computer_detail",:parent_id=>computer.id)
    DeviceType.create(:name=>"便携式计算机",:table=>"computer_detail",:parent_id=>computer.id)
    DeviceType.create(:name=>"终端",:table=>"computer_detail",:parent_id=>computer.id)

    DeviceType.create(:name=>"路由器",:table=>"router",:parent_id=>network.id)
    DeviceType.create(:name=>"交换机",:table=>"switch",:parent_id=>network.id)
    DeviceType.create(:name=>"防火墙",:table=>"firewall",:parent_id=>network.id)
    DeviceType.create(:name=>"负载均衡器",:table=>"load_banlancer",:parent_id=>network.id)

    DeviceType.create(:name=>"自动柜员机",:table=>"atm",:parent_id=>asscessory.id)
    DeviceType.create(:name=>"打印机",:table=>"printer",:parent_id=>asscessory.id)
    DeviceType.create(:name=>"刷卡器",:table=>"card_reader",:parent_id=>asscessory.id)
    DeviceType.create(:name=>"密码键盘",:table=>"pin_pad",:parent_id=>asscessory.id)
    DeviceType.create(:name=>"磁盘阵列",:table=>"disk_array",:parent_id=>asscessory.id)

    DeviceType.create(:name=>"空调",:table=>"air_condition",:parent_id=>support.id)
    DeviceType.create(:name=>"UPS",:table=>"ups",:parent_id=>support.id)
    DeviceType.create(:name=>"发电机",:table=>"generator",:parent_id=>support.id)

    User.create(:name=>"管理员",:userid=>"admin",:password=>"admin",:department=>"青海省邮政公司")
  end
end