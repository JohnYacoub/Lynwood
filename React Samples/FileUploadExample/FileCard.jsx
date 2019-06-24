import React from "react";
import { Card, CardImg, CardText, CardBody, Col } from "reactstrap";
import PropTypes from "prop-types";
import "./fileManager.css";
// import swal from "sweetalert";
import swal from "@sweetalert/with-react";

// import logger from "../../logger";
// const _logger = logger.extend("FileCard");

const FileCard = props => {
  const handleDelete = () => {
    props.deleteFile(props.file.id);
  };

  const toggle = () => {
    swal(
      <div>
        <img style={{ width: "100%" }} alt="" src={props.file.url} />
        <p className="my-4">{props.file.url}</p>
      </div>,
      {
        button: false
      }
    );
  };

  return (
    <Col md={3}>
      <Card className="Card mt-3 list-card">
        <div id="container" className="col-12">
          {props.file.name.includes("pdf") ? (
            <CardImg
              fluid
              className="px-3 pt-3 img-responsive"
              id="img"
              top
              src={"https://tinyurl.com/y2ymlfvd"}
              alt="Card cap"
            />
          ) : props.file.name.includes("doc") ? (
            <CardImg
              className="px-3 pt-3"
              id="img"
              top
              src={"https://tinyurl.com/y3qyflmh"}
              alt="Card cap"
            />
          ) : (
            <CardImg id="img" top src={props.file.url} alt="Card cap" />
          )}
        </div>
        <CardBody style={{ maxWidth: "100%" }}>
          <CardText className="text-center text-truncate">
            <em className=" text-dark ">{props.file.name}</em>
          </CardText>
          <CardText className="d-flex m-0 text-muted">
            <em
              className="text-muted mr-1 fa fa-cog fa-fw handCursor"
              onClick={toggle}
            />
            <em
              className="text-muted mr-1 ml-auto fa fa-trash fa-fw handCursor"
              onClick={handleDelete}
            />
          </CardText>
        </CardBody>
      </Card>
    </Col>
  );
};

FileCard.propTypes = {
  file: PropTypes.shape({
    id: PropTypes.number.isRequired,
    name: PropTypes.string.isRequired,
    url: PropTypes.string.isRequired,
    fileType: PropTypes.number.isRequired
  }),
  deleteFile: PropTypes.func.isRequired
};

export default FileCard;
