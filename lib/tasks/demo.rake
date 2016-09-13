namespace :demo do
  task :products => :environment do

    consultants = Consultant.create([
      {
        name: '测试外部投顾2',
        institution_type: 0,
        department_id: 10,
        is_qualified_3rd_party_institution: true
      },
      {
        name: '测试外部投顾3',
        institution_type: 0,
        department_id: 8,
        is_qualified_3rd_party_institution: true
      }
    ])

    Product.create([
      {
        name: '测试委托资产管理产品2',
        short_name: '测试产品2',
        code: 'S2345678',
        client_code: 'client2_code',
        initial_fund: 1000000000,
        staff_id: 1,
        product_type: 1,
        product_dev_type: 1,
        delegation_started_at: '2015-07-01',
        delegation_ended_at: '2017-06-30',
        delegation_duration: 2,
        sales_department_id: 5,
        operation_department_id: 2,
        consultant_id: consultants[0].id
      },
      {
        name: '测试委托资产管理产品3',
        short_name: '测试产品3',
        code: 'S2345679',
        client_code: 'client3_code',
        initial_fund: 1500000000,
        staff_id: 1,
        product_type: 2,
        product_dev_type: 1,
        delegation_started_at: '2014-02-15',
        delegation_ended_at: '2016-02-14',
        delegation_duration: 2,
        sales_department_id: 7,
        operation_department_id: 11,
        consultant_id: consultants[0].id
      },
      {
        name: '测试委托资产管理产品4',
        short_name: '测试产品4',
        code: 'S2345608',
        client_code: 'client4_code',
        initial_fund: 1000000000,
        staff_id: 1,
        product_type: 1,
        product_dev_type: 1,
        delegation_started_at: '2013-01-01',
        delegation_ended_at: '2015-12-31',
        delegation_duration: 3,
        sales_department_id: 2,
        operation_department_id: 9,
        consultant_id: consultants[1].id
      },
      {
        name: '测试委托资产管理产品5',
        short_name: '测试产品5',
        code: 'S23452',
        client_code: 'client5_code',
        initial_fund: 2000000000,
        staff_id: 1,
        product_type: 1,
        product_dev_type: 2,
        delegation_started_at: '2016-07-01',
        delegation_ended_at: '2019-06-30',
        delegation_duration: 3,
        sales_department_id: 4,
        operation_department_id: 12,
        consultant_id: consultants[1].id
      },
      {
        name: '测试委托资产管理产品6',
        short_name: '测试产品6',
        code: 'S6532',
        client_code: 'client6_code',
        initial_fund: 5000000000,
        staff_id: 1,
        product_type: 1,
        product_dev_type: 2,
        delegation_started_at: '2015-07-01',
        delegation_ended_at: '2018-06-30',
        delegation_duration: 3,
        sales_department_id: 9,
        operation_department_id: 10,
        consultant_id: consultants[0].id
      }
    ])

  end
end
