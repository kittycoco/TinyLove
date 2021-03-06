package top.genitalbean.vi.pojo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;


@Getter
@Setter
@ToString
public class ViManager {
	private String userId;
    private Double salary;
    private Integer jobId;
    private Integer status;
    private Date joinTime;
    private Date modifyTime;
}
