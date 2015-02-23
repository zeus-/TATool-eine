var TaHrList = React.createClass({

  render: function() {
    var messageListItems = [];

    this.props.hrs.forEach(function(hr) {
      messageListItems.push(<Hr key={hr.id} values={hr} />);
    });

    return (
      <ul>{messageListItems}</ul>
    );
  }
});




