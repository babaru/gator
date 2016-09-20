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
    username: 'zhanglixin', email: 'zhanglixin@sywgqh.com.cn',
    password: 12345678, password_confirmation: 12345678
  },
  {
    username: 'qiangzheng', email: 'qiangzheng@sywgqh.com.cn',
    password: 12345678, password_confirmation: 12345678
  },
  {
    username: 'shengyingfen', email: 'shengyingfen@sywgqh.com.cn',
    password: 12345678, password_confirmation: 12345678
  },
  {
    username: 'cailanhao', email: 'cailanhao@sywgqh.com.cn',
    password: 12345678, password_confirmation: 12345678
  },
  {
    username: 'lele', email: 'lele@sywgqh.com.cn',
    password: 12345678, password_confirmation: 12345678
  },
  {
    username: 'chenshaojie', email: 'chenshaojie@sywgqh.com.cn',
    password: 12345678, password_confirmation: 12345678
  },
  {
    username: 'qianyuting', email: 'qianyuting@sywgqh.com.cn',
    password: 12345678, password_confirmation: 12345678
  },
  {
    username: 'zhaochen', email: 'zhaochen@sywgqh.com.cn',
    password: 12345678, password_confirmation: 12345678
  },
  {
    username: 'chencheng', email: 'chencheng@sywgqh.com.cn',
    password: 12345678, password_confirmation: 12345678
  },
  {
    username: 'yuanwanyong', email: 'yuanwanyong@sywgqh.com.cn',
    password: 12345678, password_confirmation: 12345678
  },
  {
    username: 'fanlinghui', email: 'fanlinghui@sywgqh.com.cn',
    password: 12345678, password_confirmation: 12345678
  },
  {
    username: 'qinzenglu', email: 'qinzenglu@sywgqh.com.cn',
    password: 12345678, password_confirmation: 12345678
  },
  {
    username: 'donghaizhou', email: 'donghaizhou@sywgqh.com.cn',
    password: 12345678, password_confirmation: 12345678
  },
  {
    username: 'leiyu', email: 'leiyu@sywgqh.com.cn',
    password: 12345678, password_confirmation: 12345678
  },
  {
    username: 'wangtingpu', email: 'wangtp@sywgqh.com.cn',
    password: 12345678, password_confirmation: 12345678
  },
  {
    username: 'zhongjialin', email: 'zhongjialin@sywgqh.com.cn',
    password: 12345678, password_confirmation: 12345678
  },
  {
    username: 'xukuangda', email: 'xukuangda@sywgqh.com.cn',
    password: 12345678, password_confirmation: 12345678
  },
  {
    username: 'zhangyue', email: 'zhangyue@sywgqh.com.cn',
    password: 12345678, password_confirmation: 12345678
  },
  {
    username: 'xuna', email: 'xuna@sywgqh.com.cn',
    password: 12345678, password_confirmation: 12345678
  },
  {
    username: 'nijin', email: 'nijin@sywgqh.com.cn',
    password: 12345678, password_confirmation: 12345678
  },
  {
    username: 'yujian', email: 'yujian@sywgqh.com.cn',
    password: 12345678, password_confirmation: 12345678
  },
  {
    username: 'gechunjia', email: 'gechunjia@sywgqh.com.cn',
    password: 12345678, password_confirmation: 12345678
  }
]) if User.count == 0

seed_departments = Department.create(
[
  { name: "结算交割部" },
  { name: "客户服务部" },
  { name: "风控" },
  { name: "合规" },
  { name: "资产管理部" },
  { name: "杭州营业部" },
  { name: "郑州营业部" },
  { name: "IB业务部" },
  { name: "大连发展中心" },
  { name: "期货大厦营业部" },
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
    name: :staff,
    description: '部门成员'
  },
  {
    name: :manager,
    description: '部门管理员'
  }
]
) if Role.count == 0

seed_staffs = Staff.create(
[
  {
    name: '张丽馨',
    email: 'zhanglixin@sywgqh.com.cn',
    department_id: 1,
    position: "结算交割部经理",
    is_investment_manager: false,
    user: seed_users[1]
  },
  {
    name: '强政',
    email: 'qiangzheng@sywgqh.com.cn',
    department_id: 1,
    position: "结算交割",
    is_investment_manager: false,
    user: seed_users[2]
  },
  {
    name: '盛颖芬',
    email: 'shengyingfen@sywgqh.com.cn',
    department_id: 1,
    position: "结算交割",
    is_investment_manager: false,
    user: seed_users[3]
  },
  {
    name: '蔡岚昊',
    email: 'cailanhao@sywgqh.com.cn',
    department_id: 2,
    position: "客户服务部经理",
    is_investment_manager: false,
    user: seed_users[4]
  },
  {
    name: '乐乐',
    email: 'lele@sywgqh.com.cn',
    department_id: 2,
    position: "客户服务",
    is_investment_manager: false,
    user: seed_users[5]
  },
  {
    name: '陈少杰',
    email: 'chenshaojie@sywgqh.com.cn',
    department_id: 2,
    position: "客户服务",
    is_investment_manager: false,
    user: seed_users[6]
  },
  {
    name: '钱育亭',
    email: 'qianyuting@sywgqh.com.cn',
    department_id: 3,
    position: "交易监控部经理",
    is_investment_manager: false,
    user: seed_users[7]
  },
  {
    name: '赵辰',
    email: 'zhaochen@sywgqh.com.cn',
    department_id: 3,
    position: "交易监控",
    is_investment_manager: false,
    user: seed_users[8]
  },
  {
    name: '陈诚',
    email: 'chencheng@sywgqh.com.cn',
    department_id: 3,
    position: "交易监控",
    is_investment_manager: false,
    user: seed_users[9]
  },
  {
    name: '袁万勇',
    email: 'yuanwanyong@sywgqh.com.cn',
    department_id: 5,
    position: "副总经理兼资产管理业务总部经理",
    is_investment_manager: true,
    user: seed_users[10]
  },
  {
    name: '樊玲蕙',
    email: 'fanlinghui@sywgqh.com.cn',
    department_id: 5,
    position: "资产管理业务总部副经理",
    is_investment_manager: true,
    user: seed_users[11]
  },
  {
    name: '覃增鲁',
    email: 'qinzenglu@sywgqh.com.cn',
    department_id: 5,
    position: "资产管理业务总部经理助理",
    is_investment_manager: true,
    user: seed_users[12]
  },
  {
    name: '董海洲',
    email: 'donghaizhou@sywgqh.com.cn',
    department_id: 5,
    position: "产品营销部经理",
    is_investment_manager: true,
    user: seed_users[13]
  },
  {
    name: '雷雨',
    email: 'leiyu@sywgqh.com.cn',
    department_id: 5,
    position: "产品经理",
    is_investment_manager: true,
    user: seed_users[14]
  },
  {
    name: '王廷璞',
    email: 'wangtp@sywgqh.com.cn',
    department_id: 5,
    position: "产品经理",
    is_investment_manager: true,
    user: seed_users[15]
  },
  {
    name: '钟佳琳',
    email: 'zhongjialin@sywgqh.com.cn',
    department_id: 5,
    position: "产品经理",
    is_investment_manager: true,
    user: seed_users[16]
  },
  {
    name: '徐匡达',
    email: 'xukuangda@sywgqh.com.cn',
    department_id: 5,
    position: "产品经理",
    is_investment_manager: true,
    user: seed_users[17]
  },
  {
    name: '张玥',
    email: 'zhangyue@sywgqh.com.cn',
    department_id: 5,
    position: "产品经理",
    is_investment_manager: true,
    user: seed_users[18]
  },
  {
    name: '徐娜',
    email: 'xuna@sywgqh.com.cn',
    department_id: 4,
    position: "首席风控官",
    is_investment_manager: false,
    user: seed_users[19]
  },
  {
    name: '倪进',
    email: 'nijin@sywgqh.com.cn',
    department_id: 4,
    position: "合规副经理",
    is_investment_manager: false,
    user: seed_users[20]
  },
  {
    name: '于剑',
    email: 'yujian@sywgqh.com.cn',
    department_id: 4,
    position: "风险管理主管",
    is_investment_manager: false,
    user: seed_users[21]
  },
  {
    name: '葛纯佳',
    email: 'gechunjia@sywgqh.com.cn',
    department_id: 4,
    position: "合规岗",
    is_investment_manager: false,
    user: seed_users[22]
  }
]
) if Staff.count == 0

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
    user: seed_users[2],
    role: seed_roles[1]
  },
  {
    user: seed_users[3],
    role: seed_roles[1]
  },
  {
    user: seed_users[4],
    role: seed_roles[1]
  },
  {
    user: seed_users[5],
    role: seed_roles[1]
  },
  {
    user: seed_users[6],
    role: seed_roles[1]
  },
  {
    user: seed_users[7],
    role: seed_roles[1]
  },
  {
    user: seed_users[8],
    role: seed_roles[1]
  },
  {
    user: seed_users[9],
    role: seed_roles[1]
  },
  {
    user: seed_users[10],
    role: seed_roles[1]
  },
  {
    user: seed_users[11],
    role: seed_roles[1]
  },
  {
    user: seed_users[12],
    role: seed_roles[1]
  },
  {
    user: seed_users[13],
    role: seed_roles[1]
  },
  {
    user: seed_users[14],
    role: seed_roles[1]
  },
  {
    user: seed_users[15],
    role: seed_roles[1]
  },
  {
    user: seed_users[16],
    role: seed_roles[1]
  },
  {
    user: seed_users[17],
    role: seed_roles[1]
  },
  {
    user: seed_users[18],
    role: seed_roles[1]
  },
  {
    user: seed_users[19],
    role: seed_roles[1]
  },
  {
    user: seed_users[20],
    role: seed_roles[1]
  },
  {
    user: seed_users[21],
    role: seed_roles[1]
  },
  {
    user: seed_users[22],
    role: seed_roles[1]
  },
  {
    user: seed_users[1],
    role: seed_roles[2]
  },
  {
    user: seed_users[4],
    role: seed_roles[2]
  },
  {
    user: seed_users[7],
    role: seed_roles[2]
  },
  {
    user: seed_users[10],
    role: seed_roles[2]
  },
  {
    user: seed_users[11],
    role: seed_roles[2]
  },
  {
    user: seed_users[12],
    role: seed_roles[2]
  },
  {
    user: seed_users[13],
    role: seed_roles[2]
  },
  {
    user: seed_users[19],
    role: seed_roles[2]
  },
  {
    user: seed_users[20],
    role: seed_roles[2]
  }
]
) if Assignment.count == 0
