package com.vo;

/**
 * Created by admin on 2018/3/29.
 */
public class DataStore {
    private String workspace;
    private String dataStore;

    public DataStore() {}

    public DataStore(String workspace, String dataStore) {
        this.workspace = workspace;
        this.dataStore = dataStore;
    }

    public String getWorkspace() {
        return workspace;
    }

    public void setWorkspace(String workspace) {
        this.workspace = workspace;
    }

    public String getDataStore() {
        return dataStore;
    }

    public void setDataStore(String dataStore) {
        this.dataStore = dataStore;
    }
}
