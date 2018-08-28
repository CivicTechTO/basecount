import React, { Component } from "react";

class HeadcountHistoryRecord extends Component {
    render() {
        const percentOccupied = (this.props.headcount / this.props.totalHeadcount) * 100;
        const isFull = percentOccupied >= 100 ? "full" : "";
        return (
            <div className="headcount__history__record">
                <div className={`headcount__history__meter ${isFull}`}>
                    <div className="headcount__history__meter__bar" style={{ width: `${percentOccupied}%` }}>
                        <span className="headcount__history__meter__bar__status">{this.props.headcount}/{this.props.totalHeadcount}</span>
                    </div>
                </div>
                <p className="headcount__history__record__date">{this.props.recordDate}</p>
                <p className="headcount__history__record__time">{this.props.recordTime}</p>
            </div>
        );
    }
}

export default HeadcountHistoryRecord;