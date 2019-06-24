import React from "react";
import { Card, CardBody, CustomInput, InputGroup } from "reactstrap";
import PropTypes from "prop-types";

// import logger from "../../logger";
// const _logger = logger.extend("FileUpload");

const FileUpload = props => {
  const handlePost = () => {
    props.uploadFile(props.currentFile);
  };

  const loading = e => {
    props.loadFile(e.target.files);
  };

  return (
    <Card>
      <CardBody>
        <InputGroup>
          <CustomInput
            type="file"
            onInput={loading}
            onChange={handlePost}
            multiple
            id="file"
          />
        </InputGroup>
      </CardBody>
    </Card>
  );
};

FileUpload.propTypes = {
  file: PropTypes.shape({
    id: PropTypes.number.isRequired,
    name: PropTypes.string.isRequired,
    url: PropTypes.string.isRequired,
    fileType: PropTypes.number.isRequired
  }),
  currentFile: PropTypes.object,
  loadFile: PropTypes.func,
  uploadFile: PropTypes.func
};

export default FileUpload;
