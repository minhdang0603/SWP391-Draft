package com.web.laptoptg.model;

import jakarta.persistence.*;

@Entity
@Table(name = "product")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "cpu")
    private String cpu;

    @Column(name = "unit_price")
    private long unitPrice;

    @Column(name = "sold_unit")
    private int soldUnit;

    @Column(name = "stock_unit")
    private int stockUnit;

    @Column(name = "battery_vol")
    private String batteryVol;

    @Column(name = "operating_system")
    private String operatingSystem;

    @Column(name = "monitor_scale")
    private String monitorScale;

    @Column(name = "ram")
    private String ram;

    @Column(name = "product_name")
    private String productName;

    @Column(name = "design")
    private String design;

    @Column(name = "maintenance")
    private String maintenance;

    @Column(name = "description")
    private String description;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    private Category category;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "brand_id")
    private Brand brand;

    @Column(name = "image")
    private String image;

    public Product() {
    }

    public Product(int id, String cpu, long unitPrice, int soldUnit, int stockUnit, String batteryVol, String operatingSystem, String monitorScale, String ram, String productName, String design, String maintenance, String description, Category category, Brand brand, String image) {
        this.id = id;
        this.cpu = cpu;
        this.unitPrice = unitPrice;
        this.soldUnit = soldUnit;
        this.stockUnit = stockUnit;
        this.batteryVol = batteryVol;
        this.operatingSystem = operatingSystem;
        this.monitorScale = monitorScale;
        this.ram = ram;
        this.productName = productName;
        this.design = design;
        this.maintenance = maintenance;
        this.description = description;
        this.category = category;
        this.brand = brand;
        this.image = image;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCpu() {
        return cpu;
    }

    public void setCpu(String cpu) {
        this.cpu = cpu;
    }

    public long getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(long unitPrice) {
        this.unitPrice = unitPrice;
    }

    public int getSoldUnit() {
        return soldUnit;
    }

    public void setSoldUnit(int soldUnit) {
        this.soldUnit = soldUnit;
    }

    public int getStockUnit() {
        return stockUnit;
    }

    public void setStockUnit(int stockUnit) {
        this.stockUnit = stockUnit;
    }

    public String getBatteryVol() {
        return batteryVol;
    }

    public void setBatteryVol(String batteryVol) {
        this.batteryVol = batteryVol;
    }

    public String getOperatingSystem() {
        return operatingSystem;
    }

    public void setOperatingSystem(String operatingSystem) {
        this.operatingSystem = operatingSystem;
    }

    public String getMonitorScale() {
        return monitorScale;
    }

    public void setMonitorScale(String monitorScale) {
        this.monitorScale = monitorScale;
    }

    public String getRam() {
        return ram;
    }

    public void setRam(String ram) {
        this.ram = ram;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDesign() {
        return design;
    }

    public void setDesign(String design) {
        this.design = design;
    }

    public String getMaintenance() {
        return maintenance;
    }

    public void setMaintenance(String maintenance) {
        this.maintenance = maintenance;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}
