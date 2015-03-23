var DeleteStudentHr = React.createClass({
  
//  getInitialState: function() {
//    return {
//      hrs: this.props.studentHrs
//    }
//  },
//
  destroyHr: function(e) {
    e.preventDefault();
    var studentHrs = this.props.hrs
    var theID = this.props.thisid
    var self = this
    $.ajax({
      url: '/students/' + studentHrs.student_id + '/help_requests/' + theID,
      type: 'DELETE',
      success: function() {
       self.props.onDelete
      },
      error: function() {
       alert('Could not delete!') 
      }
    })
  },

  render: function() {
            var self = this;
            return (
              <button id="trash" onClick= {self.destroyHr} >
                <i className="fa fa-trash fa-lg"></i> 
              </button>
            );
  }
});
