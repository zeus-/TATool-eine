var TaHrList = React.createClass({

  render: function() {
    var messageListItems = [];
    this.props.hrs.forEach(function(hr) {
      messageListItems.push(<Hr key={hr.id} values={hr} />);
    });
    var completedHrs = [];
    this.props.completeHrs.forEach(function(hr) {
       completedHrs.push(<h4> {hr.description } </h4>); 
       completedHrs.push(<p> -Asked by: {hr.student_full_name } </p>); 
    });
    
    return (
      <ul>{messageListItems}
        <div className="completed-hrs">
          <h1> Completed Help Requests </h1>
          {completedHrs}
        </div>
      </ul>
    );
  }
});




