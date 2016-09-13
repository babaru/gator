# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

seed_users = User.create(
[
  {
    username: 'sys_admin', email: 'sys_admin@ctpt.io',
    password: 12345678, password_confirmation: 12345678
  },
  {
    username: 'wangtingpu', email: 'wangtp@sywgqh.com.cn',
    password: 12345678, password_confirmation: 12345678
  }
]) if User.count == 0

# seed_products = Product.create([
#   { name: "申银万国期货有限公司-嘉诚一号集合资产管理计划", short_name: "嘉诚一号",
#     client_code: "9090000310", code: "S24786", initial_fund: 6000000.00,
#     trustor_name: "招商银行", trustor_bank_name: "交通银行",
#     securities_bank_name: "申万宏源福州鼓屏路", securities_capital_account: "2017033587",
#     valuation_out_sourcing: "招商证券",
#     delegation_started_at: "2015-04-16", delegation_ended_at: "2018-04-14",
#     delegation_duration: 3, fee_calculation_standard: "前一日资产净值",
#     management_fee_ratio: 0.015, year_day_count: "当年天数", trustor_fee_ratio: 0.0015,
#     operation_fee_ratio: 0.0005, bonus: "当期收益的20%", sales_fee_ratio: 0.01,
#     sse_account_code: "8888562270", szse_account_code: "0899075801",
#     cffex_account_code: "00004257", zce_account_code: "99200147",
#     dce_account_code: "02319923", shfe_account_code: "81001734", sales_department: "福州营业部",
#     investment_consultant_reference_department: "浙江发展中心", operation_department: "资产管理业务总部",
#     investment_consultant_name: "福建省嘉诚资产管理有限公司"
#   },
#   { name: "申银万国期货有限公司-肖珊", short_name: "创富一号",
#     client_code: "9090000008", code: "S37470", initial_fund: 1000000.00,
#     trustor_name: "招商银行", trustor_bank_name: "交通银行",
#     securities_bank_name: "申万宏源福州鼓屏路", securities_capital_account: "2017033587",
#     valuation_out_sourcing: "招商证券",
#     delegation_started_at: "2015-04-16", delegation_ended_at: "2018-04-14",
#     delegation_duration: 3, fee_calculation_standard: "前一日资产净值",
#     management_fee_ratio: 0.015, year_day_count: "当年天数", trustor_fee_ratio: 0.0015,
#     operation_fee_ratio: 0.0005, bonus: "当期收益的20%", sales_fee_ratio: 0.01,
#     sse_account_code: "8888562270", szse_account_code: "0899075801",
#     cffex_account_code: "00080271", zce_account_code: "99600255",
#     dce_account_code: "01983336", shfe_account_code: "81000258", sales_department: "证券兰溪路营业部",
#     investment_consultant_reference_department: "无", operation_department: "研究所",
#     investment_consultant_name: ""
#   }
# ]) if Product.count == 0
#
# seed_clients = Client.create(
# [
#   {
#     :type => IndividualClient.name,
#     :application_number => "123456780",
#     :id_number_type => 0,
#     :id_number => "123456789123456789",
#     :name => "路人甲",
#     :traded_at => Time.now,
#     :person_in_charge_id_number_type => nil,
#     :person_in_charge_id_number => nil,
#     :person_in_charge_name => nil,
#     :fund_trading_account_number => "12345678",
#     :sales_man_code => "3201",
#     :business_code => "001",
#     :branch_store_number => "001",
#     :fund_account_number => nil
#   },
#   {
#     :type => IndividualClient.name,
#     :application_number => "123456781",
#     :id_number_type => 0,
#     :id_number => "123456789123456788",
#     :name => "张三",
#     :traded_at => Time.now,
#     :person_in_charge_id_number_type => nil,
#     :person_in_charge_id_number => nil,
#     :person_in_charge_name => nil,
#     :fund_trading_account_number => "12345678",
#     :sales_man_code => "3201",
#     :business_code => "001",
#     :branch_store_number => "001",
#     :fund_account_number => nil
#   },
#   {
#     :type => IndividualClient.name,
#     :application_number => "123456782",
#     :id_number_type => 0,
#     :id_number => "123456789123456787",
#     :name => "王国强",
#     :traded_at => Time.now,
#     :person_in_charge_id_number_type => nil,
#     :person_in_charge_id_number => nil,
#     :person_in_charge_name => nil,
#     :fund_trading_account_number => "12345678",
#     :sales_man_code => "3201",
#     :business_code => "001",
#     :branch_store_number => "001",
#     :fund_account_number => nil
#   },
#   {
#     :type => InstitutionClient.name,
#     :application_number => "123456783",
#     :id_number_type => 0,
#     :id_number => "123456789123456789",
#     :name => "光蓝投资",
#     :traded_at => Time.now,
#     :person_in_charge_id_number_type => 0,
#     :person_in_charge_id_number => "123456789123456789",
#     :person_in_charge_name => "路人甲",
#     :fund_trading_account_number => "12345678",
#     :sales_man_code => "3201",
#     :business_code => "001",
#     :branch_store_number => "001",
#     :fund_account_number => nil
#   },
#   {
#     :type => InstitutionClient.name,
#     :application_number => "123456784",
#     :id_number_type => 0,
#     :id_number => "123456789123456789",
#     :name => "鱼永鑫商贸",
#     :traded_at => Time.now,
#     :person_in_charge_id_number_type => 0,
#     :person_in_charge_id_number => "123456789123456786",
#     :person_in_charge_name => "张兰",
#     :fund_trading_account_number => "12345678",
#     :sales_man_code => "3201",
#     :business_code => "001",
#     :branch_store_number => "001",
#     :fund_account_number => nil
#   }
#   ])
#
seed_departments = Department.create(
[
    { name: "杭州营业部" },
    { name: "郑州营业部" },
    { name: "IB业务部" },
    { name: "大连发展中心" },
    { name: "期货大厦营业部" },
    { name: "资产管理部" },
    { name: "宁波营业部" },
    { name: "浙江发展中心" },
    { name: "南京营业部" },
    { name: "大连营业部" },
    { name: "银行开发部" },
    { name: "新昌路营业部" },
    { name: "化工事业部" },
    { name: "广州营业部" },
    { name: "福州营业部" },
    { name: "北京营业部" },
    { name: "有色金属事业部" },
    { name: "油脂油料事业部" },
    { name: "深圳发展中心" },
    { name: "上海期货大厦营业部" },
    { name: "青岛营业部" },
    { name: "黄金事业部" },
    { name: "重庆营业部" },
    { name: "西安营业部" },
    { name: "零售业务总部" },
    { name: "上海东体育会路营业部" },
    { name: "农产品事业部" },
    { name: "机构业务部" },
    { name: "钢材事业部" },
    { name: "成都营业部" },
    { name: "北京发展中心" },
    { name: "白糖事业部" },
    { name: "西安营业部" },
    { name: "研究所" },
    { name: "证券基金开发部" }
  ]
) if Department.count == 0

seed_banks = Bank.create([
  { name: "中国工商银行" },
  { name: "中国建设银行" },
  { name: "中国农业银行" },
  { name: "中国银行" },
  { name: "招商银行" },
  { name: "兴业银行" }
]) if Bank.count == 0

seed_roles = Role.create(
[
  {
    name: :admin,
    description: '系统管理员'
  },
  {
    name: :product_manager,
    description: '产品经理'
  },
  {
    name: :am_manager,
    description: '资管部管理员'
  }
]
) if Role.count == 0

seed_assignments = Assignment.create(
[
  {
    user: seed_users[0],
    role: seed_roles[0]
  },
  {
    user: seed_users[1],
    role: seed_roles[1]
  },
  {
    user: seed_users[1],
    role: seed_roles[2]
  }
]
) if Assignment.count == 0

seed_staffs = Staff.create(
[
  {
    name: '王廷璞',
    email: 'wangtp@sywgqh.com.cn',
    department_id: 5,
    is_investment_manager: true
  }
]
) if Staff.count == 0
