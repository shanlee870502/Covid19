//
//  StatisticView.swift
//  CoronaVirus
//
//  Created by User01 on 2021/1/10.
//

import Foundation
import SwiftUI
import SwiftUICharts

struct StatisticView: View{
    var cases :[(String,Double)]
    var deathes:[(String,Double)]
    var recovered:[(String,Double)]
    static let taskDateFormat: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }()
    
    var body: some View{
        BarChartView(data: ChartData(values: cases), title: "確診人數", legend: "Basic",style: Styles.barChartStyleNeonBlueLight, form: CGSize(width:350, height:200)).padding(5)
        BarChartView(data: ChartData(values: deathes), title: "死亡人數", legend: "Quarterly",style: Styles.barChartMidnightGreenLight, form: CGSize(width:350, height:200)).padding(5)
        BarChartView(data: ChartData(values: recovered), title: "康復人數", legend: "Quarterly",style: Styles.barChartStyleOrangeLight, form: CGSize(width:350, height:200)).padding(5)
    }
}

//        VStack{
//            BarChartView(data: ChartData(values: [("2018 Q4",63150), ("2019 Q1",50900), ("2019 Q2",77550), ("2019 Q3",79600), ("2019 Q4",92550)]), title: "Sales", legend: "Quarterly",style: Styles.barChartMidnightGreenLight, form: CGSize(width:300, height:200)).padding(5)
//            BarChartView(data: ChartData(values: [("2018 Q4",63150), ("2019 Q1",50900), ("2019 Q2",77550), ("2019 Q3",79600), ("2019 Q4",92550)]), title: "Sales", legend: "Quarterly",style: Styles.barChartStyleNeonBlueLight, form: CGSize(width:300, height:200)).padding(5)
//            BarChartView(data: ChartData(values: [("2018 Q4",63150), ("2019 Q1",50900), ("2019 Q2",77550), ("2019 Q3",79600), ("2019 Q4",92550)]), title: "Sales", legend: "Quarterly",style: Styles.barChartStyleNeonBlueLight,form: CGSize(width:300, height:200)).padding(5)
//        }.padding(10)



//List(statistic.indices, id:\.self, rowContent:{(index) in
//
//    ForEach( statistic[index].cases.data.keys.sorted(), id: \.self) { key in
//        Text("\(key, formatter: Self.taskDateFormat)")
//        Text(String(statistic[index].cases.data[key]!))
//
//    }
//})


