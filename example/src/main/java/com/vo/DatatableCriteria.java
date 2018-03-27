package com.vo;

import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2018/3/26.
 */
public class DatatableCriteria {
    private int draw;
    private int start;
    private int length;

    private Map<SearchCriteria, String> search;

    private List<Map<OrderCriteria, String>> order;


    public enum OrderCriteria{
        column,
        dir
    }

    public enum SearchCriteria{
        value,regex
    }

    public int getDraw() {
        return draw;
    }

    public void setDraw(int draw) {
        this.draw = draw;
    }

    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getLength() {
        return length;
    }

    public void setLength(int length) {
        this.length = length;
    }

    public Map<SearchCriteria, String> getSearch() {
        return search;
    }

    public void setSearch(Map<SearchCriteria, String> search) {
        this.search = search;
    }

    public List<Map<OrderCriteria, String>> getOrder() {
        return order;
    }

    public void setOrder(List<Map<OrderCriteria, String>> order) {
        this.order = order;
    }

}
