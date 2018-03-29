package com.vo;

/**
 * Created by admin on 2018/3/29.
 */
public class Layer {
    private String type;
    private String title;
    private String workspace;
    private String layer;
    private String dataStore;
    private String srs;

    public Layer() {}

    public Layer(String type, String title, String workspace, String layer, String dataStore, String srs) {
        this.type = type;
        this.title = title;
        this.workspace = workspace;
        this.layer = layer;
        this.dataStore = dataStore;
        this.srs = srs;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getWorkspace() {
        return workspace;
    }

    public void setWorkspace(String workspace) {
        this.workspace = workspace;
    }

    public String getLayer() {
        return layer;
    }

    public void setLayer(String layer) {
        this.layer = layer;
    }

    public String getDataStore() {
        return dataStore;
    }

    public void setDataStore(String dataStore) {
        this.dataStore = dataStore;
    }

    public String getSrs() {
        return srs;
    }

    public void setSrs(String srs) {
        this.srs = srs;
    }
}
