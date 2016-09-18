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
    department_id: 6,
    is_investment_manager: true,
    user: seed_users[1]
  }
]
) if Staff.count == 0
