package tdtu.bookstore.model;

import java.text.NumberFormat;
import java.util.Date;
import java.util.Locale;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.Data;


@Entity
@Table(name = "books")
@Data
public class Book {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	private String name;

	private Integer price;

	private Integer authorid;

	private Integer publisherid;

	private String size;

	private Integer page;

	private String image;

	private String description;

    private String category;

    @Temporal(TemporalType.TIMESTAMP)
    private Date adddate;
    
    @PrePersist
    private void onCreate() {
    	adddate = new Date();
    }
    
    private Integer quantity;
	
    public String getTotalPriceString() {
		return NumberFormat.getNumberInstance(Locale.US).format(this.price*this.quantity);
	}

	public String getPriceString() {
		return NumberFormat.getNumberInstance(Locale.US).format(this.price);
	}

	public String getDescriptionHTML() {
		return this.description.replaceAll("\n", "<br>");
	}
}
