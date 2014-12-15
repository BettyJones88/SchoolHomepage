﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class InformationDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string categoryType = Request.QueryString["id"];
            int categoryId = Convert.ToInt32(categoryType);
            if (null == categoryType || categoryType.Equals(string.Empty))
            {
                this.showFalseMessage("请输入正确的请求代号！");
                return;
            }

            ServiceNews serviceNews = new ServiceNews();
            DataSet informationDataset = serviceNews.GetInformation(categoryId);
            if (null == informationDataset || 1 > informationDataset.Tables.Count || 1 > informationDataset.Tables[0].Rows.Count)
            {
                this.showFalseMessage("此类别内容待添加！");
                return;
            }
            this.TitleLabel.Text = informationDataset.Tables[0].Rows[0]["name"].ToString();
            this.ContentLabel.Text = informationDataset.Tables[0].Rows[0]["article"].ToString();
        }
    }

    private void showFalseMessage(string message)
    {
        this.failure_div.Visible = true;
        this.success_div.Visible = false;

        this.failure_div.InnerText = message;
    }
}