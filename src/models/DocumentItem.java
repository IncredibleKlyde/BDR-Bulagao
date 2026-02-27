/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

public class DocumentItem {

    private int id;
    private String name;
    private double fee;

    public DocumentItem(int id, String name, double fee) {
        this.id = id;
        this.name = name;
        this.fee = fee;
    }

    public int getId() { return id; }
    public double getFee() { return fee; }

    @Override
    public String toString() {
        return name;
    }
}
