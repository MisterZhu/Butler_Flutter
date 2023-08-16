package com.wishare.community.smartcommunity.entity;

/**
 * Copyright (c), 浙江慧享信息科技有限公司
 * FileName: OCRInfoEntity
 * Author: wang tao
 * Email: wangtao1@lvchengfuwu.com
 * Date: 2023/2/1 9:04
 * Description:
 */
public class OCRInfoEntity {

    // 姓名
    private String name;
    // 性别
    private String gender;
    // 民族
    private String ethnic;
    // 身份证号码
    private String idNumber;
    // 生日
    private String birthday;
    // 地址
    private String address;

    // 注册日期
    private String signDate;
    // 失效日期
    private String expiryDate;
    // 身份证签发机关
    private String issueAuthority;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEthnic() {
        return ethnic;
    }

    public void setEthnic(String ethnic) {
        this.ethnic = ethnic;
    }

    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getSignDate() {
        return signDate;
    }

    public void setSignDate(String signDate) {
        this.signDate = signDate;
    }

    public String getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(String expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getIssueAuthority() {
        return issueAuthority;
    }

    public void setIssueAuthority(String issueAuthority) {
        this.issueAuthority = issueAuthority;
    }
}
