/*
 * Copyright 2004-2005 The Apache Software Foundation or its licensors,
 *                     as applicable.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.apache.jackrabbit.core.search.lucene;

import org.apache.jackrabbit.core.ItemManager;
import org.apache.jackrabbit.core.NamespaceResolver;
import org.apache.jackrabbit.core.NoPrefixDeclaredException;
import org.apache.jackrabbit.core.QName;
import org.apache.log4j.Logger;

import javax.jcr.NodeIterator;
import javax.jcr.RepositoryException;
import javax.jcr.query.QueryResult;
import javax.jcr.query.RowIterator;

/**
 * Implements the <code>javax.jcr.query.QueryResult</code> interface.
 */
class QueryResultImpl implements QueryResult {

    /** The logger instance for this class */
    private static final Logger log = Logger.getLogger(QueryResultImpl.class);

    /** The item manager of the session executing the query */
    private final ItemManager itemMgr;

    /** The UUIDs of the result nodes */
    private final String[] uuids;

    /** The scores of the result nodes */
    private final Float[] scores;

    /** The select properties */
    private final QName[] selectProps;

    /** The namespace resolver of the session executing the query */
    private final NamespaceResolver resolver;

    /**
     * Creates a new query result.
     * @param itemMgr the item manager of the session executing the query.
     * @param uuids the UUIDs of the result nodes.
     * @param scores the score values of the result nodes.
     * @param selectProps the select properties of the query.
     * @param resolver the namespace resolver of the session executing the query.
     */
    public QueryResultImpl(ItemManager itemMgr,
                           String[] uuids,
                           Float[] scores,
                           QName[] selectProps,
                           NamespaceResolver resolver) {
        this.uuids = uuids;
        this.scores = scores;
        this.itemMgr = itemMgr;
        this.selectProps = selectProps;
        this.resolver = resolver;
    }

    /**
     * @see QueryResult#getPropertyNames()
     */
    public String[] getPropertyNames() throws RepositoryException {
        try {
            String[] propNames = new String[selectProps.length];
            for (int i = 0; i < selectProps.length; i++) {
                propNames[i] = selectProps[i].toJCRName(resolver);
            }
            return propNames;
        } catch (NoPrefixDeclaredException npde) {
            String msg = "encountered invalid property name";
            log.debug(msg);
            throw new RepositoryException(msg, npde);

        }
    }


    /**
     * @see QueryResult#getNodes()
     */
    public NodeIterator getNodes() throws RepositoryException {
        return new NodeIteratorImpl(itemMgr, uuids, scores);
    }

    /**
     * @see QueryResult#getRows()
     */
    public RowIterator getRows() throws RepositoryException {
        return new RowIteratorImpl(new NodeIteratorImpl(itemMgr, uuids, scores), selectProps, resolver);
    }
}
