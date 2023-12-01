package tdtu.bookstore.model;

import java.text.NumberFormat;
import java.util.Date;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;

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
import tdtu.bookstore.repository.UserRepository;

@Entity
@Table(name = "bills")
@Data
public class Bill {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	private Integer userid;

	private String carts;

	private Integer total;

	private String address;

	private String phone;

	private Integer status = 0;

	@Temporal(TemporalType.TIMESTAMP)
	private Date adddate;

	@PrePersist
	private void onCreate() {
		adddate = new Date();
	}
	
	public String getTotalPriceString() {
		return NumberFormat.getNumberInstance(Locale.US).format(this.total);
	}
}
