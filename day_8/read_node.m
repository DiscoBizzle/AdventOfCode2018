function [InputIndex, NodeValue] = read_node(Input, InputIndex)

    NumChildren = Input(InputIndex);
    InputIndex = InputIndex + 1;
    NumMetaData = Input(InputIndex);
    InputIndex = InputIndex + 1;

    global NodeIndex;
    CurrNodeIndex = NodeIndex;
    NodeIndex = NodeIndex + 1;
    
    for ChildIndex = 1:NumChildren
        [InputIndex, CurrNodeValue] = read_node(Input, InputIndex);
        ChildValues(ChildIndex) = CurrNodeValue;
    end;
    
    global MetaData;
    MetaData{CurrNodeIndex} = Input(InputIndex:(InputIndex + NumMetaData - 1));
    InputIndex = InputIndex + NumMetaData;

    if NumChildren == 0 
        NodeValue = sum(MetaData{CurrNodeIndex});
    else 
        ChildIndices = MetaData{CurrNodeIndex}((MetaData{CurrNodeIndex}) > 0 & (MetaData{CurrNodeIndex} <= NumChildren));
        NodeValue = sum(ChildValues(ChildIndices));
    end;
end