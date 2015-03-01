var TaHrList = React.createClass({

  render: function() {
    var messageListItems = [];
    this.props.hrs.forEach(function(hr) {
      messageListItems.push(<Hr key={hr.id} values={hr} />);
    });
    var completedHrs = [];
    this.props.completeHrs.forEach(function(hr) {
      completedHrs.push(<CompletedHr key={hr.id} values={hr} />);
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




