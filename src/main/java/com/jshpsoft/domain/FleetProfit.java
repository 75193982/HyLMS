package com.jshpsoft.domain;
/**
 * 车队利润
 * @author  ww 
 * @date 2017年1月11日 上午10:56:25
 */
public class FleetProfit {
	
	private double carIncome;//主营收入（商品车）
	private double shCarIncome;//二手车及其他
	private double insuranceIncome;//保险赔款
	private double incomeSum;//车队运费总收入
	
	private double driverCost;//驾驶员报销
	private double lukatong;//鲁卡通
	private double insuranceCost;//保险分摊
	private double carRepairCost;//大车维修包月费
	private double driverPay;//驾驶员工资
	private double officePay;//车队办公人员工资
	private double tireCost;//轮胎费用
	private double fleetCost;//车队费用
	private double rentCost;//场地租金
	private double trailerCost;//挂车年审
	private double erWeiCost;//二维
	private double oilCardCost;//油卡折现成本
	private double costSum;//车队运费成本
	
	public double getCarIncome() {
		return carIncome;
	}
	public void setCarIncome(double carIncome) {
		this.carIncome = carIncome;
	}
	public double getShCarIncome() {
		return shCarIncome;
	}
	public void setShCarIncome(double shCarIncome) {
		this.shCarIncome = shCarIncome;
	}
	public double getInsuranceIncome() {
		return insuranceIncome;
	}
	public void setInsuranceIncome(double insuranceIncome) {
		this.insuranceIncome = insuranceIncome;
	}
	public double getDriverCost() {
		return driverCost;
	}
	public void setDriverCost(double driverCost) {
		this.driverCost = driverCost;
	}
	public double getLukatong() {
		return lukatong;
	}
	public void setLukatong(double lukatong) {
		this.lukatong = lukatong;
	}
	public double getInsuranceCost() {
		return insuranceCost;
	}
	public void setInsuranceCost(double insuranceCost) {
		this.insuranceCost = insuranceCost;
	}
	public double getCarRepairCost() {
		return carRepairCost;
	}
	public void setCarRepairCost(double carRepairCost) {
		this.carRepairCost = carRepairCost;
	}
	public double getDriverPay() {
		return driverPay;
	}
	public void setDriverPay(double driverPay) {
		this.driverPay = driverPay;
	}
	public double getOfficePay() {
		return officePay;
	}
	public void setOfficePay(double officePay) {
		this.officePay = officePay;
	}
	public double getTireCost() {
		return tireCost;
	}
	public void setTireCost(double tireCost) {
		this.tireCost = tireCost;
	}
	public double getFleetCost() {
		return fleetCost;
	}
	public void setFleetCost(double fleetCost) {
		this.fleetCost = fleetCost;
	}
	public double getRentCost() {
		return rentCost;
	}
	public void setRentCost(double rentCost) {
		this.rentCost = rentCost;
	}
	public double getTrailerCost() {
		return trailerCost;
	}
	public void setTrailerCost(double trailerCost) {
		this.trailerCost = trailerCost;
	}
	public double getErWeiCost() {
		return erWeiCost;
	}
	public void setErWeiCost(double erWeiCost) {
		this.erWeiCost = erWeiCost;
	}
	public double getOilCardCost() {
		return oilCardCost;
	}
	public void setOilCardCost(double oilCardCost) {
		this.oilCardCost = oilCardCost;
	}
	public double getIncomeSum() {
		return incomeSum;
	}
	public void setIncomeSum(double incomeSum) {
		this.incomeSum = incomeSum;
	}
	public double getCostSum() {
		return costSum;
	}
	public void setCostSum(double costSum) {
		this.costSum = costSum;
	}
	
	
}
